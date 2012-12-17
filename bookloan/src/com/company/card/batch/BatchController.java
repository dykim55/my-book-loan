package com.company.card.batch;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

import com.company.framework.mvc.controller.SIVController;

/**
 * @author
 * 
 */
public class BatchController extends SIVController {
	
	/* ======================================================
	 * 속성 선언부
	 ====================================================== */
	private IBatchService batchService;
	
	/* ======================================================
	 * 메소드 구현부
	 ====================================================== */
	public ModelAndView batchIssueView(HttpServletRequest req, HttpServletResponse res) {
		return new ModelAndView(this.success);
	}
	
	/* ======================================================
	 * getters, setters 선언부
	 ====================================================== */
	public void setBatchService(IBatchService batchService) {
		this.batchService = batchService;
	}
}
