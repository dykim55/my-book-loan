package com.company.book.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.company.framework.mvc.controller.SIVController;

/**
 * @author
 * 
 */
public class MemberController extends SIVController {

	private IMemberService memberService;
	
	public ModelAndView memberView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	public void setMemberService(IMemberService memberService) {
		this.memberService = memberService;
	}
}
