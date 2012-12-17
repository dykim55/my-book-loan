package com.company.framework.utils;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * Project: 아주대학교 전자출결 시스템<br>
 * @date : 2010. 1. 19.<br>
 * @author 김경석<br>
 * <br>
 * <strong>설명</strong> : <br>
 * <strong>관련테이블</strong> : <br>
 * <strong>관련서비스</strong> : <br>
 * <br>
 */
public class HttpUtil {
	/**
	 * 파라미터를 추출하여 맵형태로 반환한다. 배열형태의 파라미터는 제외함.
	 * 
	 * @param req
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, String> getParameterMap(HttpServletRequest req) {
		Enumeration<String>	keys	= req.getParameterNames();
		Map<String, String>	params	= new HashMap<String, String>();
		
		String	_key;
		while (keys.hasMoreElements()) {
			_key	= keys.nextElement();
			params.put(_key, getValue(req, _key));
		}
		
		return params;
	}
	
	/**
	 * name에 해당하는 파라미터를 반환. 공백을 제거하며 ""일 경우 null을 반환한다.
	 * 
	 * @param req
	 * @param name
	 * @return
	 */
	public static String getValue(HttpServletRequest req, String name) {
		String	value	= req.getParameter(name);
		return value == null || "".equals(value.trim()) ? null : value.trim();
	}
	
	/**
	 * source의 문자열 항목을 추출하여 req로 전달
	 * @param source
	 * @param target
	 */
	@SuppressWarnings("unchecked")
	public static void passParameter(Map source, HttpServletRequest req) {
		Iterator<String>	keys	= source.keySet().iterator();
		
		Object	_key;
		while (keys.hasNext()) {
			_key	= keys.next();
			if (_key instanceof String && source.get(_key) instanceof String)
				req.setAttribute((String)_key, source.get(_key));
		}
	}
}
