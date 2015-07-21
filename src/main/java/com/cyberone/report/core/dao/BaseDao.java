package com.cyberone.report.core.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

public class BaseDao {

	protected DB promDb;
	protected DB rptDb;

	private static final long h24 = 86400000;
	private static final int timezoneOffset = Calendar.getInstance()
			.getTimeZone().getRawOffset();

	private HashMap<Integer, String> portServiceMap;
	
	@SuppressWarnings("unused")
	private String checkMethodName;
	@SuppressWarnings("unused")
	private long lLastTime;
	
	public BaseDao(DB promDb, DB rptDb) {
		this.promDb = promDb;
		this.rptDb = rptDb;
		
		//포트 서비스네임 조회
		portServiceMap = new HashMap<Integer, String>(); 
		DBCollection dbCollection = promDb.getCollection("PortServiceName");
		DBCursor dbCursor = dbCollection.find();
		for (DBObject obj : dbCursor) {
			portServiceMap.put((Integer)obj.get("port"), (String)obj.get("serviceName"));
		}
	}
	
	//관제대상 장비현황
	public List<HashMap<String, Object>> getAssetList(String[] arrAssets) throws Exception {
		
		List<HashMap<String, Object>> assetList = new ArrayList<HashMap<String, Object>>();
		 
		SimpleDateFormat dateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		DBCollection dbCollection = promDb.getCollection("Product");
		BasicDBObject condition = new BasicDBObject();
		condition.put("deleted", false);
		DBCursor dbCursor = dbCollection.find(condition);
		HashMap<String, DBObject> productMap = new HashMap<String, DBObject>();
		for (DBObject obj : dbCursor) {
			productMap.put(((Integer)obj.get("productCode")).toString(), obj);
		}
		
		dbCollection = promDb.getCollection("Asset");
		
		for (int i = 0; i < arrAssets.length; i++) {
			String[] saTemp = arrAssets[i].split("_");
			BasicDBObject searchQuery = new BasicDBObject("assetCode", Integer.parseInt(saTemp[0]));
			DBObject asset = dbCollection.findOne(searchQuery);
			
			DBCollection policyCollection = promDb.getCollection("AssetPolicy");
			BasicDBObject searchPolicyQuery = new BasicDBObject("assetCode", (Integer)asset.get("assetCode"));
			DBObject policy = policyCollection.findOne(searchPolicyQuery);
			
			DBObject basePolicy = (DBObject)policy.get("basePolicy");
			int baseDay = 1;
			if (basePolicy.containsField("statMonthBaseDay")) {
				baseDay = (Integer)basePolicy.get("statMonthBaseDay");
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("_id", arrAssets[i]);
			map.put("assetCode", (Integer)asset.get("assetCode"));
			map.put("assetName", (String)asset.get("assetName"));
			map.put("assetIp", (String)asset.get("assetIp"));
			map.put("baseDay", baseDay);
			
			Date createTime = (Date)asset.get("createTime");
			String strCreateTime = dateTime.format(createTime);
			strCreateTime = strCreateTime.substring(0, 10);
			map.put("createTime", strCreateTime);

			DBObject productObj = productMap.get(((Integer)asset.get("productCode")).toString());
			map.put("productName", (String)productObj.get("productName") );
			map.put("productType", saTemp[1]);
			
			//DDOS Radware_DP_ODS/Sniper_DDX 구분
			if (saTemp[1].equals("DDOS")) {
				if ((Integer)asset.get("productCode") == 506126) {
					map.put("etc", "1");
				} else if ((Integer)asset.get("productCode") == 506119) {
					map.put("etc", "2");
				} else {
					map.put("etc", "2");
				}
			} else {
				map.put("etc", "0");
			}

			assetList.add(map);
		}

		Comparator<HashMap<String, Object>> comparator = new Comparator<HashMap<String, Object>>() {
			@Override
			public int compare(HashMap<String, Object> m1, HashMap<String, Object> m2) {
				String o1 = (String)m1.get("productType");
				String o2 = (String)m2.get("productType");
				if (o1 == null || o2 == null) {
					return 0;
				}
				return o1.compareTo(o2);
			}
		};

		Collections.sort(assetList, comparator);
		
		return assetList;
	}
	
	public String getPortServiceName(int nPort) {
		String strServiceName = portServiceMap.get(nPort);
		return strServiceName != null ? strServiceName : String.valueOf(nPort);
	}	
	
	public Date getDay(Date date) {
		long time = date.getTime();
		time = time + timezoneOffset;
		time = time - (time % h24); // 24H
		time = time - timezoneOffset;
		date.setTime(time);
		return date;
	}

	public List<String> getPeriod(Date from, Date to, int sort) {

		SimpleDateFormat day = new SimpleDateFormat("yyyy-MM-dd");
		List<String> period = new ArrayList<String>();

		Date startDay = null;
		Date endDay = null;

		if (from != null) {
			startDay = getDay(new Date(from.getTime()));
		}

		if (to != null) {
			endDay = new Date(to.getTime());
		}

		if (sort == -1) {

			while (endDay.after(startDay)) {
				period.add(day.format(endDay));
				endDay.setTime(endDay.getTime() - h24);
			}
		} else if (sort == 1) {
			while (startDay.before(endDay)) {
				period.add(day.format(startDay));
				startDay.setTime(startDay.getTime() + h24);
			}
		}

		return period;
	}

	public List<String> getPeriodMonth(String sEndDay, int nMonth, int sort) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMM");

		Calendar startCal = null; 
		Calendar endCal = null;
		if (nMonth > 0) {
			Date startDate = sdf.parse(sEndDay); 
			startCal = getCalendar(startDate);
			
			Date endDate = sdf.parse(sEndDay);
			endCal = getCalendar(endDate);
			endCal.add(Calendar.MONTH, nMonth + 1);
			endCal.add(Calendar.SECOND, -1);
		} else if (nMonth < 0) {
			Date startDate = sdf.parse(sEndDay);
			startCal = getCalendar(startDate);
			startCal.add(Calendar.MONTH, nMonth);
			
			Date endDate = sdf.parse(sEndDay);
			endCal = getCalendar(endDate);
			endCal.add(Calendar.MONTH, 1);
			endCal.add(Calendar.SECOND, -1);
		}
		
		List<String> period = new ArrayList<String>();
		
		if (sort == -1) {
			while (endCal.after(startCal)) {
				period.add(sdf2.format(endCal.getTime()));
				endCal.add(Calendar.MONTH, -1);
			}
		} else if (sort == 1) {
			while (startCal.before(endCal)) {
				period.add(sdf2.format(startCal.getTime()));
				startCal.add(Calendar.MONTH, 1);
			}
		}
		
		return period;
	}

	public List<String> getPeriodDay(String sStartDay, String sEndDay, int nMonth, int sort) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		
		List<String> period = new ArrayList<String>();
		
		Calendar startCal = null; 
		Calendar endCal = null;
		if (nMonth >= 0) {
			Date startDate = sdf.parse(sStartDay); 
			startCal = getCalendar(startDate);
			
			Date endDate = sdf.parse(sEndDay);
			endCal = getCalendar(endDate);
			endCal.add(Calendar.MONTH, nMonth);
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			endCal.add(Calendar.SECOND, -1);
			
			if (sort == -1) {
				while (endCal.after(startCal)) {
					period.add(sdf2.format(endCal.getTime()));
					endCal.add(Calendar.DAY_OF_MONTH, -1);
				}
			} else if (sort == 1) {
				while (startCal.before(endCal)) {
					period.add(sdf2.format(startCal.getTime()));
					startCal.add(Calendar.DAY_OF_MONTH, 1);
				}
			}
		} else if (nMonth < 0) {
			Date startDate = sdf.parse(sStartDay);
			startCal = getCalendar(startDate);
			startCal.add(Calendar.MONTH, -1);
			
			Date endDate = sdf.parse(sEndDay);
			endCal = getCalendar(endDate);
			
			SimpleDateFormat sdfMM = new SimpleDateFormat("yyyyMM");
			
			if (sort == -1) {
			} else if (sort == 1) {
				while (Integer.valueOf(sdfMM.format(startCal.getTime())) < Integer.valueOf(sdfMM.format(endCal.getTime()))) {
					for (int i = startCal.get(Calendar.DAY_OF_MONTH); i <= 31; i++) {
						period.add(startCal.get(Calendar.YEAR) + lZero((startCal.get(Calendar.MONTH) + 1)) + lZero(i));
					}
					startCal.add(Calendar.MONTH, 1);
					for (int i = 1; i <= endCal.get(Calendar.DAY_OF_MONTH); i++) {
						period.add(startCal.get(Calendar.YEAR) + lZero((startCal.get(Calendar.MONTH) + 1)) + lZero(i));
					}
				}
			}
		}
		
		return period;
	}

	public List<String> getPeriodDay2(String sStartDay, String sEndDay, int nMonth, int sort) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		
		Calendar startCal = null; 
		Calendar endCal = null;
		if (nMonth >= 0) {
			Date startDate = sdf.parse(sStartDay); 
			startCal = getCalendar(startDate);
			
			Date endDate = sdf.parse(sEndDay);
			endCal = getCalendar(endDate);
			endCal.add(Calendar.MONTH, nMonth);
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			endCal.add(Calendar.SECOND, -1);
		} else if (nMonth < 0) {
			Date startDate = sdf.parse(sStartDay);
			startCal = getCalendar(startDate);
			startCal.add(Calendar.MONTH, nMonth);
			
			Date endDate = sdf.parse(sEndDay);
			endCal = getCalendar(endDate);
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			endCal.add(Calendar.SECOND, -1);
		}
		
		List<String> period = new ArrayList<String>();

		if (sort == -1) {
			while (endCal.after(startCal)) {
				period.add(sdf2.format(endCal.getTime()));
				endCal.add(Calendar.DAY_OF_MONTH, -1);
			}
		} else if (sort == 1) {
			while (startCal.before(endCal)) {
				period.add(sdf2.format(startCal.getTime()));
				startCal.add(Calendar.DAY_OF_MONTH, 1);
			}
		}
		
		return period;
	}
	
	public Calendar getCalendar(Date date) {
		Calendar cal = new GregorianCalendar( TimeZone.getTimeZone( "GMT+09:00"), Locale.KOREA );
		cal.setTime(date);
		return cal;
	}
	
	public String getLastDayOfMonth(String strMonth) throws Exception {
		String strLastDayOfMonth = "31";
		SimpleDateFormat day = new SimpleDateFormat("yyyy-MM");
		try {
			Date tmpDate = day.parse(strMonth);
			Calendar tmpCal = getCalendar(tmpDate);
			strLastDayOfMonth = String.valueOf(tmpCal.getActualMaximum(Calendar.DAY_OF_MONTH));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return strLastDayOfMonth;
	}
	
	public String getSearchPeriod(String sStartDay, String sEndDay) throws Exception {
		String strStartDate = "";
		String strEndDate = "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			Date startDate = sdf.parse(sStartDay);
			Calendar startCal = getCalendar(startDate);
			
			Date endDate = sdf.parse(sEndDay);
			Calendar endCal = getCalendar(endDate);
			
			strStartDate = startCal.get(Calendar.YEAR) + "년 " + lZero((startCal.get(Calendar.MONTH) + 1)) + "월 " + lZero(startCal.get(Calendar.DAY_OF_MONTH)) + "일";
			strEndDate = endCal.get(Calendar.YEAR) + "년 " + lZero((endCal.get(Calendar.MONTH) + 1)) + "월 " + lZero(endCal.get(Calendar.DAY_OF_MONTH)) + "일";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return strStartDate + " ~ " + strEndDate;
	}

	public String lZero(int n) {
		return n < 10 ? "0" + n : String.valueOf(n);
	}
	
	//보안관제 실적 현황
	public DBObject getDetectResult(
			String strPrefix, 
			String strDateType, 
			int assetCode, 
			String sEndDay) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		
		try {
			Date tmpDate = sdf.parse(sEndDay);
			Calendar tmpCal = getCalendar(tmpDate);		
			
			DBCollection dbCollection = rptDb.getCollection(strPrefix + "_" + assetCode + "_" + strDateType);
			BasicDBObject condition = new BasicDBObject();
			condition.put("rptGubun", 1);
			condition.put("year", tmpCal.get(Calendar.YEAR));
			condition.put("month", tmpCal.get(Calendar.MONTH) + 1);
			DBCursor dbCursor = dbCollection.find(condition);
			
			List<DBObject> tmpList = dbCursor.toArray();
			return tmpList.size() > 0 ? tmpList.get(0) : null;
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//월간 침해위협 탐지보고 내역
	public List<HashMap<String, Object>> getDetectResultList(List<Integer> assetCodes, String sStartDay, String sEndDay) throws Exception {

		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			Date startDate = sdf.parse(sStartDay);
			Calendar startCal = getCalendar(startDate);
			
			Date endDate = sdf.parse(sEndDay);
			Calendar endCal = getCalendar(endDate);
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			endCal.add(Calendar.SECOND, -1);
			
			for (int i = 0; i < assetCodes.size(); i++) {
				StartTimeCheck("getDetectResultList(" + assetCodes.get(i) + ")");
				
				DBCollection dbCollection = promDb.getCollection("EventAnnotation");

				BasicDBObject condition = new BasicDBObject();
				condition.put("createTime", new BasicDBObject("$gte", startCal.getTime()).append("$lte", endCal.getTime()));
				condition.put("assetCode", assetCodes.get(i));
				condition.put("logCode", 1);
				condition.put("status", 2);
				DBObject match = new BasicDBObject("$match", condition);

				DBObject project = new BasicDBObject();
				DBObject fields = new BasicDBObject();
				fields.put("createTime", 1);
				fields.put("assetName", 1);
				fields.put("ruleName", 1);
				fields.put("srcIp", 1);
				project.put("$project", fields);

				BasicDBObject keys = new BasicDBObject();
				keys.put("createTime", new BasicDBObject("$substr", Arrays.asList("$createTime", 0, 10)));
				keys.put("assetName", "$assetName");
				keys.put("ruleName", "$ruleName");
				keys.put("srcIp", "$srcIp");
				DBObject groupFields = new BasicDBObject( "_id", keys);
				groupFields.put("count", new BasicDBObject( "$sum", 1));
				DBObject group = new BasicDBObject("$group", groupFields);
				
				DBObject sortFields = new BasicDBObject();
				sortFields.put("_id.assetName", 1);
				sortFields.put("_id.createTime", 1);
			    DBObject sort = new BasicDBObject("$sort", sortFields );
				
				AggregationOutput output = dbCollection.aggregate(match, project, group, sort);

				Iterable<DBObject> results = output.results();
				for (DBObject dbObj : results) {
					@SuppressWarnings("unchecked")
					HashMap<String,Object> mapId = (HashMap<String,Object>)dbObj.get("_id");
					HashMap<String, Object> map = new HashMap<String, Object>();
				    map.put("no", resultList.size() + 1);
				    map.put("date", (String)mapId.get("createTime"));
				    map.put("assetName", (String)mapId.get("assetName"));
				    map.put("title", (String)mapId.get("ruleName"));
				    map.put("srcIp", (String)mapId.get("srcIp"));
				    map.put("count", ((Number)dbObj.get("count")).longValue());
				    resultList.add(map);
				}
				EndTimeCheck();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return resultList;
	}

	//월 성능정보
	public List<DBObject> getPerformanceMonth(int assetCode, String sEndDay) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		
		try {
			Date tmpDate = sdf.parse(sEndDay);
			Calendar tmpCal = getCalendar(tmpDate);		
			
			DBCollection dbCollection = rptDb.getCollection("SV_" + assetCode + "_MON");
			BasicDBObject condition = new BasicDBObject();
			condition.put("rptGubun", 3);
			condition.put("year", tmpCal.get(Calendar.YEAR));
			condition.put("month", tmpCal.get(Calendar.MONTH) + 1);
			DBCursor dbCursor = dbCollection.find(condition).sort(new BasicDBObject("name", 1));

			return dbCursor.toArray();
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public Iterable<DBObject> getPerformanceChange(int assetCode, String sStartDay, String sEndDay, String sField) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		try {
			Date startDate = sdf.parse(sStartDay);
			Calendar startCal = getCalendar(startDate);
			startCal.add(Calendar.MONTH, -1);
			
			Date endDate = sdf.parse(sEndDay);
			Calendar endCal = getCalendar(endDate);
			endCal.add(Calendar.DAY_OF_MONTH, 1);
			endCal.add(Calendar.SECOND, -1);

			DBCollection dbCollection = rptDb.getCollection("SV_" + assetCode + "_DY");

			BasicDBObject condition = new BasicDBObject();
			condition.put("rptDate", new BasicDBObject("$gte", startCal.getTime()).append("$lte", endCal.getTime()));
			condition.put("rptGubun", 3);
			condition.put("name", sField);
			DBObject match = new BasicDBObject("$match", condition);
			
			DBObject project = new BasicDBObject();
			DBObject fields = new BasicDBObject();
			fields.put("year", 1);
			fields.put("month", 1);
			fields.put("day", 1);
			fields.put("avg", 1);
			fields.put("max", 1);
			fields.put("min", 1);
			project.put("$project", fields);
			
			DBObject sortFields = new BasicDBObject();
			sortFields.put("year", 1);
			sortFields.put("month", 1);
			sortFields.put("day", 1);
		    DBObject sort = new BasicDBObject("$sort", sortFields );

			AggregationOutput output = dbCollection.aggregate(match, project, sort);

			return output.results();

		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	protected void StartTimeCheck(String strMethodName) {
		checkMethodName = strMethodName;
		lLastTime = System.currentTimeMillis();
	}
	
	protected void EndTimeCheck() {
		//System.out.println("#### " + checkMethodName + " : " + (System.currentTimeMillis() - lLastTime));
	}
}
