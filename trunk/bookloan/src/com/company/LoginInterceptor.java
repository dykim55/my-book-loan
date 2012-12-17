package com.company;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 
 * Project: <br>
 * @date : <br>
 * @author <br>
 * <br>
 * <strong>설명</strong> : <br>
 * <strong>관련테이블</strong> : <br>
 * <strong>관련서비스</strong> : <br>
 * <br>
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	/** 로그인 처리 예외목록 <예외URL, 예외URL> */
	private Map<String, String>		exceptions			= null;
	
	/** 로그인 페이지 */
	private String					loginUrl			= null;
	
	private static int				contextNameLength	= -1;
	
	public Logger	logger	= Logger.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		//한글깨짐처리
		response.setContentType("text/html; charset=utf-8");
		
		if (contextNameLength == -1) {	// URL 검사를 위해 contextName의 길이를 set.
			contextNameLength = request.getContextPath().length();
		}
		
		UserSession session = UserSessionManager.getUserSession(request);
		if (session != null) {
			request.setAttribute("userId", session.getUserId());
		}
		
		// 예외 URL을 검증하고 예외로 선언되어 있으면 pass
		String requestedUrl = request.getRequestURI().substring(contextNameLength);

		logger.info(":::: [INFO] [" + request.getMethod() + "]requestedUrl : " + requestedUrl);

		if (exceptions.containsKey(requestedUrl)) {
			return true;
		}
		
		// 그렇지 않을 경우 session을 검증한다. session이 존재하지 않을 경우 오류.
		if (!UserSessionManager.isLoggedOn(request)) {
			if (requestedUrl.endsWith(".ajax")) {
				PrintWriter writer = response.getWriter();
				writer.print("{\"status\":\"error\",\"type\":\"login\"}");
				writer.flush();
			} else {
				response.sendRedirect(request.getContextPath() + loginUrl);
			}
			return false;
		}
		return true;
	}
	
	public void setExceptions(Map<String, String> exceptions) {
		this.exceptions = exceptions;
	}

	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}
}
