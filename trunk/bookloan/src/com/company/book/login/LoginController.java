package com.company.book.login;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.UserSessionManager;
import com.company.book.dto.MngInfoDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class LoginController extends SIVController {

	private ILoginService loginService;
	
	public ModelAndView loginView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	public ModelAndView login(HttpServletRequest req, HttpServletResponse res) throws Exception {

		boolean result = false;
		
		String strId = req.getParameter("login_id");
		String strPassword = req.getParameter("login_password");

		//패스워드 암호화 인코딩처리
		//String	passwd = Utils.seedEncode(strPassword);
		String	passwd = strPassword;

		MngInfoDTO dto = (MngInfoDTO) DataUtils.dtoBuilder(req, MngInfoDTO.class);
		dto.setM_id(strId);
		
		UserSession userSession = new UserSession();
		
		if (strId != null && strId.length() > 0) {
			List<MngInfoDTO> list = loginService.login(dto);

			//로그인 아이디 DB조회
			if (list.size() > 0) {
				dto = list.get(0);
				if (!passwd.equals(dto.getM_password())) {
					result = false;
				} else {
					result = true;
				}
			} else {
				result = false;
			}
		}
		
		String strNext = this.success;
		
	    // 인증성공
	    if (result == true) {
	    	userSession.setUserId(strId);
	    	userSession.setArea("001");
	    	UserSessionManager.createUserSession(req, userSession);
	    } else {
	    	req.setAttribute("id", strId);
	    	req.setAttribute("message", "인증 오류!!!");
	    	req.setAttribute("login_failed", "ID");
	    	
	    	strNext = "/WEB-INF/jsp/login/login.jsp";
	    }
		
		return new ModelAndView(strNext);
	}
	
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		UserSession session = UserSessionManager.getUserSession(req);
		if (session != null) {
			UserSessionManager.removeSession(req);
		}
		
		return new ModelAndView(this.success);
	}

	public void setLoginService(ILoginService loginService) {
		this.loginService = loginService;
	}
}
