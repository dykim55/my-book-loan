package com.cyberone.report.core.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyberone.report.core.dao.FwDao;
import com.cyberone.report.core.datasource.SynthesisDataSource;
import com.mongodb.DBObject;

@Service
public class FwService {
	
	@Autowired
	private FwDao fwDao;

	private List<String> contentsList = new ArrayList<String>();
	
	public String addContents(String strContents) {
		return addContents(strContents, "");
	}
	public String addContents(String strContents, String strIndent) {
		contentsList.add(strIndent + strContents);
		return strContents;
	}
	
	public void FW_SessionLogMonthlyChange(String sStartDay, String sEndDay, int assetCode, int[] nSearchPorts, HashMap<String, Object> assetReportInfo) throws Exception {

    	List<HashMap<String, Object>> FW_6_1_1_G = new ArrayList<HashMap<String, Object>>();
    	List<DBObject> outToIn = fwDao.FW_SessionLogMonth(assetCode, 1, sEndDay, 0);   	

    	assetReportInfo.put("SubChapter2", addContents(".1 최근 6개월 세션 로그 추이", "  "));
    	
    	HashMap<String, DBObject> mapOutToIn = new HashMap<String, DBObject>(); 
    	for (DBObject val : outToIn) {
    		String sAction = (String)val.get("action");
    		String sYear = ((Integer)val.get("year")).toString();
    		String sMonth = ((Integer)val.get("month")).toString();
    		sMonth = sMonth.length() == 1 ? "0" + sMonth : sMonth;
    		mapOutToIn.put(sAction + sYear + sMonth, val);
    	}

    	List<String> monthPeriod = fwDao.getPeriodMonth(sEndDay, -5, 1);
    	
    	String[] saGubun = {"차단", "허용"};
    	for (int i = 1; i >= 0; i--) {
    		for (int j = 0; j < 6; j++) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		DBObject val = mapOutToIn.get(String.valueOf(i) + monthPeriod.get(j));
	    		map.put("gubun", saGubun[i]);
	    		map.put("month", Integer.valueOf(monthPeriod.get(j)));
	    		map.put("count", val != null ? ((Number)val.get("count")).longValue() : 0);
	    		
	    		FW_6_1_1_G.add(map);
    		}	    		
    	}

    	/*
    	if (nSearchPorts != null) {
    		for (int i = 0; i < nSearchPorts.length; i++) {
	    		String strServiceName = reportDao.getPortServiceName(nSearchPorts[i]);
		    	outToIn = reportDao.FW_SessionLogMonth(assetCode, 1, sEndDay, nSearchPorts[i]);   	
	    	
		    	mapOutToIn = new HashMap<String, DBObject>(); 
		    	for (DBObject val : outToIn) {
		    		String sYear = ((Integer)val.get("year")).toString();
		    		String sMonth = ((Integer)val.get("month")).toString();
		    		sMonth = sMonth.length() == 1 ? "0" + sMonth : sMonth;
		    		mapOutToIn.put(sYear + sMonth, val);
		    	}
	    	
	    		for (int j = 0; j < 6; j++) {
		    		HashMap<String, Object> map = new HashMap<String, Object>();
		    		DBObject val = mapOutToIn.get(monthPeriod.get(j));
		    		map.put("gubun", strServiceName);
		    		map.put("month", Integer.valueOf(monthPeriod.get(j)));
		    		map.put("count", val != null ? ((Number)val.get("count")).longValue() : 0);
		    		
		    		FW_6_1_1_G.add(map);
	    		}
    	    }
    	}*/
    	
    	assetReportInfo.put("FW_6_1_1_G", new SynthesisDataSource(FW_6_1_1_G));
    	assetReportInfo.put("FW_6_1_1_T", new SynthesisDataSource(FW_6_1_1_G));
    	assetReportInfo.put("SubChapter3", addContents(".1.1 외부에서 내부로의 세션 로그 발생 추이", "    "));
    	
    	/*
		 * 보고서 6.1.2번 항목, 내부에서 외부로의 세션로그 발생 추이
		 */
    	List<HashMap<String, Object>> FW_6_1_2_G = new ArrayList<HashMap<String, Object>>();
    	List<DBObject> inToOut = fwDao.FW_SessionLogMonth(assetCode, 0, sEndDay, 0);   	
    	
    	HashMap<String, DBObject> mapInToOut = new HashMap<String, DBObject>(); 
    	for (DBObject val : inToOut) {
    		String sAction = (String)val.get("action");
    		String sYear = ((Integer)val.get("year")).toString();
    		String sMonth = ((Integer)val.get("month")).toString();
    		sMonth = sMonth.length() == 1 ? "0" + sMonth : sMonth;
    		mapInToOut.put(sAction + sYear + sMonth, val);
    	}

    	for (int i = 1; i >= 0; i--) {
    		for (int j = 0; j < 6; j++) {
	    		HashMap<String, Object> map = new HashMap<String, Object>();
	    		DBObject val = mapInToOut.get(String.valueOf(i) + monthPeriod.get(j));
	    		map.put("gubun", saGubun[i]);
	    		map.put("month", Integer.valueOf(monthPeriod.get(j)));
	    		map.put("count", val != null ? ((Number)val.get("count")).longValue() : 0);
	    		
	    		FW_6_1_2_G.add(map);
    		}	    		
    	}

    	assetReportInfo.put("FW_6_1_2_G", new SynthesisDataSource(FW_6_1_2_G));
    	assetReportInfo.put("FW_6_1_2_T", new SynthesisDataSource(FW_6_1_2_G));		
    	assetReportInfo.put("SubChapter4", addContents(".1.2 내부에서 외부로의 세션 로그 발생 추이", "    "));
	}

	public List<HashMap<String, Object>> getAssetList(String[] arrAssets) throws Exception {
		return fwDao.getAssetList(arrAssets);
	}
	
}
