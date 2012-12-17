package com.company.framework.exception;

public interface IMessageResover {
	/**
	 * 오류코드임을 표현.
	 */
	public static final String	ERROR_CODE	= "e-code";
	
	/**
	 * code에 해당하는 메시지를 반환.
	 * 
	 * @param code
	 * @return
	 */
	public String getMessage(String code);
}