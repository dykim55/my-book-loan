package com.company.framework.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 다양한 날짜 형식을 지원한다
 * 
 * @author 김지영<br> 
 * @project ep1000<br>
 * @date 2007. 06. 25<br>
 * <br>
 */
public class DateUtil {
    /**
     * 현재일자에 addedDate 만큼의 일수를 더한 일자를 YYYYMMDD 형태로 반환.
     * @param addedDate
     * @return
     */
    public static String getDate(int addedDate) {
        Calendar    _calendar = new GregorianCalendar();
        _calendar.add(Calendar.DATE, addedDate);
        StringBuffer sBuffer = new StringBuffer();
        
        /** year */
        sBuffer.append(_calendar.get(Calendar.YEAR));
        
        /** month */
        if ( (_calendar.get(Calendar.MONTH) + 1) < 10) sBuffer.append("0");
        sBuffer.append(_calendar.get(Calendar.MONTH)+1);
        
        /** date */
        if ( _calendar.get(Calendar.DATE) < 10) sBuffer.append("0");
        sBuffer.append(_calendar.get(Calendar.DATE));
        
        return sBuffer.toString();
    }
    
	public static String getDate(String format, int day) {
		
		Date today = new Date();
		Calendar cal = Calendar.getInstance ();
        cal.setTime (today);
        cal.add (Calendar.DAY_OF_MONTH, day);
        SimpleDateFormat simple = new SimpleDateFormat(format);

		return simple.format(cal.getTime());
	}
    
    /**
     * 현재 년월일시분초를 메소드명과 같은 형식으로 반환.
     * @return
     */
    public static  String getYYYYMMDDHH24MISS() {
        return getCurrentDateTime("", "", "");
    }
    
    /**
     * cal의 년월일시분초를 YYYYMMDDHH24MISS 형식으로 반환
     * @param cal
     * @return
     */
    public static String getYYYYMMDDHH24MISS(Calendar cal) {
    	return getDateTime(cal, "", "", "");
    }
    
    /** 현재 일시를 반환 */
    public static String getCurrentDateTime(String dateDeli, String timeDeli, String deli) {
        return getCurrentDate(dateDeli) + deli + getCurrentTime(timeDeli);
    }

    /**
     * 현재년월일을 반환.
     * 
     * @param deli
     * @return
     */
    public static String getCurrentDate(String deli) {
        Calendar    _calendar = new GregorianCalendar();
        return getDate(_calendar, deli);
    }
    
    /**
     * 현재시간을 반환
     * 
     * @param deli
     * @return
     */
    public static String getCurrentTime(String deli) {
        Calendar    _calendar = new GregorianCalendar();
        return getTime(_calendar, deli);
    }
    
    /**
     * cal의 년월일시분초를 문자열로 작성하여 반환.
     * 
     * @param cal
     * @param dateDeli 날짜 구분자
     * @param timeDeli 시간 구분자
     * @param deli 날짜, 시간 구분자
     * @return
     */
    public static String getDateTime(Calendar cal, String dateDeli, String timeDeli, String deli) {
        return getDate(cal, dateDeli) + deli + getTime(cal, timeDeli);
    }
    
    /**
     * cal의 날짜(년월일)를 문자열로 작성하여 반환
     * 
     * @param cal
     * @param deli 구분자
     * @return
     */
    public static String getDate(Calendar cal, String deli) {
        StringBuffer sBuffer = new StringBuffer();
        
        /** year */
        sBuffer.append(cal.get(Calendar.YEAR));
        sBuffer.append(deli);
        
        /** month */
        if ( (cal.get(Calendar.MONTH) + 1) < 10) sBuffer.append("0");
        sBuffer.append(cal.get(Calendar.MONTH)+1);
        sBuffer.append(deli);
        
        /** date */
        if ( cal.get(Calendar.DATE) < 10) sBuffer.append("0");
        sBuffer.append(cal.get(Calendar.DATE));
        
        return sBuffer.toString();
    }
    
    /**
     * cal의 시간(시분초)을 문자열로 작성하여 반환
     * 
     * @param cal
     * @param deli 구분자
     * @return
     */
    public static String getTime(Calendar cal, String deli) {
        StringBuffer sBuffer = new StringBuffer();
        
        /** hour */
        if ( cal.get(Calendar.HOUR_OF_DAY) < 10) sBuffer.append("0");
        sBuffer.append(cal.get(Calendar.HOUR_OF_DAY));
        sBuffer.append(deli);
        
        /** minute */
        if ( cal.get(Calendar.MINUTE) < 10) sBuffer.append("0");
        sBuffer.append(cal.get(Calendar.MINUTE));
        sBuffer.append(deli);
        
        /** second */
        if ( cal.get(Calendar.SECOND) < 10) sBuffer.append("0");
        sBuffer.append(cal.get(Calendar.SECOND));
        
        return sBuffer.toString();
    }
}