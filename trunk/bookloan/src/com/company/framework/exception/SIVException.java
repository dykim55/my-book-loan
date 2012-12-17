package com.company.framework.exception;

/**
 * SIV에서 사용할 예외.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2006. 9. 21.
 * <br>
 */
public class SIVException extends Exception {
	/**
	 * 생성할 때 코드값을 초기화한다.
	 * 
	 * @param code 오류코드
	 */
	public SIVException(String code) {
		super();
		this.code	= code;
	}
	
	/**
	 * error code
	 */
	private		String	code	= null;

	/**
	 * 오류코드를 반환한다.
	 * 
	 * @return
	 */
	public String getCode() {
		return code;
	}

	/**
	 * 오류코드를 지정한다.
	 * 
	 * @param code
	 */
	public void setCode(String code) {
		this.code = code;
	}
}


