package com.company.framework.filters;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

/**
 * 인증된 사용자 여부를 판단하여 해당 request에 적법한 사용자만 해당 URL에 접근할 수 있도록 한다.<br>
 * web.xml의 filter에 등록하고 사용한다.<br>
 * 모든 요청에 대하여 필터링 할 경우 최초 접근할 수 있는 지점이 없어지므로 최초 접근 지점을 허용할 수 있도록 맵핑해야 하는데 주의한다.<br>
 * 예를 들어 위 예에서  forwardUrl인 /index.main은 필터링에서 제외되어야 한다.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2007. 12. 27
 * <br>
 */
public class LoginValidation extends OncePerRequestFilter {

	private String	forwardUrl;
	
	private String	sessionName;
	
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) 
			throws ServletException, IOException {
		if (request.getSession(false) == null ||
				request.getSession(false).getAttribute(sessionName) == null) {
			System.out.println("no session " + sessionName + ". forward " + forwardUrl);
			request.getRequestDispatcher(forwardUrl).forward(request, response);
		}
		
		else
			filterChain.doFilter(request, response);
	}

	public String getForwardUrl() {
		return forwardUrl;
	}

	public void setForwardUrl(String forwardUrl) {
		this.forwardUrl = forwardUrl;
	}

	public String getSessionName() {
		return sessionName;
	}

	public void setSessionName(String sessionName) {
		this.sessionName = sessionName;
	}
}


