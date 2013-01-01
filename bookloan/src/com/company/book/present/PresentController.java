package com.company.book.present;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.UserSessionManager;
import com.company.book.dto.LoanHistoryDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class PresentController extends SIVController {

	private IPresentService presentService;
	
	public ModelAndView presentView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}
	
	public ModelAndView searchLoanHistory( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());

		if (dto.getM_search_value() != null && dto.getM_search_value().length() > 0) {
			if (dto.getM_search_tp().equals("1")) {
				dto.setM_title(dto.getM_search_value());
			} else if (dto.getM_search_tp().equals("2")) {
				dto.setM_name(dto.getM_search_value());
			} else if (dto.getM_search_tp().equals("3")) {
				dto.setM_tel_no(dto.getM_search_value());
			}
		}
		
		List<LoanHistoryDTO> list = null;
		
		list = presentService.searchLoanHistory(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}

	public ModelAndView searchRcvPresent( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());

		List<LoanHistoryDTO> list = null;
		
		list = presentService.searchRcvPresent(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}

	public ModelAndView searchLoanHistoryExcel( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());

		if (dto.getM_search_value() != null && dto.getM_search_value().length() > 0) {
			if (dto.getM_search_tp().equals("1")) {
				dto.setM_title(dto.getM_search_value());
			} else if (dto.getM_search_tp().equals("2")) {
				dto.setM_name(dto.getM_search_value());
			} else if (dto.getM_search_tp().equals("3")) {
				dto.setM_tel_no(dto.getM_search_value());
			}
		}
		
		List<LoanHistoryDTO> list = null;
		
		list = presentService.searchLoanHistoryExcel(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public void setPresentService(IPresentService presentService) {
		this.presentService = presentService;
	}
}
