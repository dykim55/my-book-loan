package com.company.framework.mvc.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

/**
 * web application에서 list를 처리하기 위한 list collection.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2010.01.04
 * <br>
 */
public class SIVController extends MultiActionController {
	/**
	 * logging object. log4j
	 */
	public Logger	logger	= Logger.getLogger(this.getClass());
	
	/**
	 * 수행 성공시 반환할 jsp url
	 */
	protected String	success;

	/**
	 * 수행 실패시 반환할 jsp url
	 */
	protected String	failure;
	
	/**
	 * 수행 성공시 이동할 jsp url을 반환한다.
	 * 
	 * @return
	 */
	public String getSuccess() {
		return success;
	}

	/**
	 * 수행 성공시 이동할 jsp url을 설정한다.
	 * @param success
	 */
	public void setSuccess(String success) {
		this.success = success;
	}

	/**
	 * 수행 실패시 이동할 jsp url을 반환한다.
	 * 
	 * @return
	 */
	public String getFailure() {
		return failure;
	}

	/**
	 * 수행 실패시 이동할 jsp url을 설정한다.
	 * 
	 * @param failure
	 */
	public void setFailure(String failure) {
		this.failure = failure;
	}
	
	/**
	 * 파라미터의 공백을 제거하고 반환. 없거나 공백일 경우 null로 치환.
	 * 
	 * @param req	request 객체
	 * @param name 파라미터 명
	 * @return
	 */
	public String trimValue(HttpServletRequest req, String name) {
		String	value	= req.getParameter(name);

		return value == null || "".equals(value.trim()) ? null : value.trim();
	}
	
	/**
	 * request의 parameter를 맵으로 반환.
	 * 배열형태의 파라미터는 반환하지 않음.
	 * 
	 * @param req
	 * @param result	null이면 새로 생성된 맵에 담아 반환.
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public final Map<String, String> getParameters(HttpServletRequest req, Map<String, String> result) {
		if (result == null)		result	= new HashMap<String, String>();
		
		Enumeration<String>	names	= req.getParameterNames();
		String				_name;
		while (names.hasMoreElements()) {
			_name	= names.nextElement();
			result.put(_name, trimValue(req, _name));
		}
		
		return result;
	}
	
}