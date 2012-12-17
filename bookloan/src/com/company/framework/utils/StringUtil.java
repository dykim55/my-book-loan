package com.company.framework.utils;

/**
 * 문자열 관련 utility성 메소드들을 지원한다.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2007. 12. 27
 * <br>
 */
public class StringUtil {
	/**
	 * 왼쪽에 pader를 padding하여 length길이로 반환
	 * 
	 * @param str null이면 ""으로 치환 후 연산.
	 * @param pader null이면 " "으로 치환 후 연산.
	 * @param length str.length보다 작으면 str을 그대로 반환.
	 * @return
	 */
	public static String leftPadding(String str, String padder, int length) {
		if (padder == null) padder	= " ";
		if (str == null) str		= "";
		
		StringBuffer	buf	= new StringBuffer();
		for (int i = length - str.length(); i > 0; i--) {
			buf.append(padder);
		}
		
		buf.append(str);
		return buf.toString();
	}
	
	/**
	 * 오른쪽에 pader를 padding하여 length길이로 반환.
	 * 
	 * @param str null이면 ""으로 치환 후 연산.
	 * @param pader null이면 " "으로 치환 후 연산.
	 * @param length str.length보다 작으면 str을 그대로 반환.
	 * @return
	 */
	public static String rightPadding(String str, String padder, int length) {
		if (padder == null) padder	= " ";
		if (str == null) str		= "";
		
		StringBuffer	buf	= new StringBuffer(str);
		while (buf.length() < length) {
			buf.append(padder);
		}
		
		return buf.toString();
	}
	
	/**
	 * BCD Data를 String형태로 반환.
	 * @param data
	 * @return
	 */
	public static String getBCDToString(byte[] data) {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			buffer.append( (data[i] >> 4) & 0x0F ).append( (data[i]) & 0x0F );
		}
		return buffer.toString();
	}
	
	/** 
	 * number data를 String형태로 반환.
	 * @param data
	 * @return
	 */
	public static String toNumberString(byte[] data) {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			buffer.append( data[i] );
		}
		return buffer.toString();
	}
	
    /**
	 * Ascii로 읽어 String형태로 반환
	 * @param data
	 * @return
	 */
	public static String toAsciiString(byte[] data) {
		
		return new String(data);
	}
}