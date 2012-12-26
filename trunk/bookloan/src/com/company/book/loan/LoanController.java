package com.company.book.loan;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.company.framework.mvc.controller.SIVController;

/**
 * @author
 * 
 */
public class LoanController extends SIVController {

	private ILoanService loanService;
	
	public ModelAndView loanView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	public void setLoanService(ILoanService loanService) {
		this.loanService = loanService;
	}
}
