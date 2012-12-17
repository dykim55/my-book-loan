package com.company.framework.utils;

import java.text.NumberFormat;
import java.util.List;
import java.util.Map;

/**
 * 수치형 데이터를 #,### 형태의 문자열로 formatting 하는 utility성 메소드들을 지원한다.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2007. 12. 27
 * <br>
 */
public class NumberUtil {
	public static final int	INTEGER	= 0;
	
	public static final int	LONG	= 1;
	
	public static final int	SHORT	= 2;
	
	public static final int	DOUBLE	= 3;
	
	public static final int	FLOAT	= 4;
	
	/**
	 * map 내의 key에 해당하는 항목들을 format한다.
	 * @param keys
	 * @param types
	 * @param map
	 * @return
	 */
	public static Map<String, Object> formatNumber(String[] keys, int[] types, Map<String, Object> map) {
		NumberFormat	nf	= NumberFormat.getInstance();
		
		for (int i = 0; i < keys.length; i++) {
			map.put(keys[i], formatNumber((Number)map.get(keys[i]), types[i], nf));
		}
		
		return map;
	}
	
	/**
	 * java.util.Map으로 이루어진 maps의 항목들 중 keys에 해당하는 항목들을 format한다.
	 * @param keys
	 * @param types
	 * @param maps
	 * @return
	 */
	public static List<Map<String, Object>> formatNumber(String[] keys, int[] types, List<Map<String, Object>> maps) {
		
		Map<String, Object>	_map = null;
		for (int i = 0; i < maps.size(); i++) {
			_map = (Map<String, Object>)maps.get(i);
			
			formatNumber(keys, types, _map);
		}
		
		return maps;
	}
	
	public static String formatNumber(int number) {
		return NumberFormat.getInstance().format(number);
	}
	
	public static String formatNumber(long number) {
		return NumberFormat.getInstance().format(number);
	}

	public static String formatNumber(short number) {
		return NumberFormat.getInstance().format(number);
	}

	public static String formatNumber(float number) {
		return NumberFormat.getInstance().format(number);
	}

	public static String formatNumber(double number) {
		return NumberFormat.getInstance().format(number);
	}

	private static String formatNumber(Number number, int type, NumberFormat nf) {
		switch (type) {
		case	INTEGER	:
			return nf.format(number.intValue());
		case	LONG :
			return nf.format(number.longValue());
		case	SHORT :
			return nf.format(number.shortValue());
		case	DOUBLE :
			return nf.format(number.doubleValue());
		case	FLOAT :
			return nf.format(number.floatValue());
		}
		
		return number.toString();
	}
	
	/**
	 * 
	 * @param number
	 * @param type
	 * @return
	 */
	public static String formatNumber(Number number, int type) {
		NumberFormat	nf	= NumberFormat.getInstance();
		
		return formatNumber(number, type, nf);
	}
}


