package com.company;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

/**
 * 유저 세션 관리 유틸
 * @author Administrator
 *
 */
public class UserSessionManager {
	/** 사용자 정보를 담을 세션키 */
	public static final String	USER_KEY	= "session-user";
	
	static Logger	logger	= Logger.getLogger(UserSessionManager.class);
	
	/**
	 * 세션을 생성한다.
	 * 
	 * @param request request
	 * @param user 사용자정보
	 */
	public static void createUserSession(HttpServletRequest req, UserSession user) {
		req.getSession(true).setAttribute(USER_KEY, user);
		req.getSession().setAttribute("test", "test");
		
		logger.info(":::: [INFO] Created Session : " + user.getUserId());
	}
	
	/**
	 * 인증여부를 확인한다.
	 * 
	 * @param request
	 * @return
	 */
	public static boolean isLoggedOn(HttpServletRequest req) {
		if (req.getSession(false) != null && 
				req.getSession(false).getAttribute(USER_KEY) != null) {
			return true;
		}
			
		return false;
	}
	
	/**
	 * 세션의 값을 가져온다. 세션이 생성되었는지 여부가 불확실 할 경우 인증여부를 확인 후 이 메소드를 사용한다.
	 * 
	 * @param request
	 * @param user
	 * @return
	 * @see <code>isLoggedOn()</code>
	 */
	public static UserSession getUserSession(HttpServletRequest req) {
		UserSession	userSession	= (UserSession)req.getSession().getAttribute(USER_KEY);
		
		return userSession;
	}
	
	/**
	 * 세션을 제거한다.
	 * 
	 * @param request
	 */
	public static void removeSession(HttpServletRequest req) {
		HttpSession	session	= req.getSession(false);
		if (session != null) session.invalidate();
	}
}