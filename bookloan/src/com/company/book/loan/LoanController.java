package com.company.book.loan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.UserSessionManager;
import com.company.book.dto.BookInfoDTO;
import com.company.book.dto.LoanHistoryDTO;
import com.company.book.dto.MemberInfoDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class LoanController extends SIVController {

	private ILoanService loanService;
	
	public ModelAndView loanView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		ModelMap map =  new ModelMap();
		map.put("m_no", dto.getM_no());
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView searchMemberInfo( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//학생정보 조회		
		MemberInfoDTO dto = (MemberInfoDTO) DataUtils.dtoBuilder(req, MemberInfoDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());

		List<MemberInfoDTO> list = null;
		
		if ((dto.getM_no() != null && !dto.getM_no().isEmpty()) || 
			(dto.getM_name() != null && !dto.getM_name().isEmpty()) || 
			(dto.getM_phone_no() != null && !dto.getM_phone_no().isEmpty())) {
			list = loanService.searchMemberInfo(dto);
		}
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView searchLoanHistory( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());

		List<LoanHistoryDTO> list = null;
		
		list = loanService.searchLoanHistory(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}

	public ModelAndView searchBookInfo( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		BookInfoDTO dto = (BookInfoDTO) DataUtils.dtoBuilder(req, BookInfoDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());
		
		List<BookInfoDTO> list = null;
		
		list = loanService.searchBookInfo(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView registrationLoan(HttpServletRequest req, HttpServletResponse res) throws Exception {

		ModelMap map = new ModelMap();
		
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		dto.setSessionData(req);
		
		try { 
			loanService.insertLoanHistory(dto);
		} catch (Exception e) {
			map.addAttribute("err_code", "0003");
			map.addAttribute("err_message", "대출이력 등록 중 오류가 발생했습니다.");
			return new ModelAndView(this.success, map);
		}
		
		logger.info(":::: [INFO] 회원번호[" + dto.getM_no() + "] 도서번호[" + dto.getM_book_no() + "] 대출 성공!!!");
		
		map.addAttribute("err_code", "0000");
		map.addAttribute("err_message", "정상처리 되었습니다.");
		return new ModelAndView(this.success, map);
	}

	public ModelAndView updateReceiveLoan(HttpServletRequest req, HttpServletResponse res) throws Exception {

		ModelMap map = new ModelMap();
		
		LoanHistoryDTO dto = (LoanHistoryDTO) DataUtils.dtoBuilder(req, LoanHistoryDTO.class);
		dto.setSessionData(req);
		
		try { 
			if (dto.getM_rcv_tp().equals("1") || dto.getM_rcv_tp().equals("2")) {
				loanService.updateReceiveLoan(dto);
				if (dto.getM_rcv_tp().equals("2")) {//대출연장
					loanService.insertLoanHistory(dto);
				}
				logger.info(":::: [INFO] 회원번호[" + dto.getM_no() + "] 도서번호[" + dto.getM_book_no() + "] 회수 성공!!!");
			} else {
				loanService.updateCancelReceiveLoan(dto);
				logger.info(":::: [INFO] 회원번호[" + dto.getM_no() + "] 도서번호[" + dto.getM_book_no() + "] 회수취소 성공!!!");
			}
		} catch (Exception e) {
			map.addAttribute("err_code", "0003");
			map.addAttribute("err_message", "대출회수 처리 중 오류가 발생했습니다.");
			return new ModelAndView(this.success, map);
		}
		
		map.addAttribute("err_code", "0000");
		map.addAttribute("err_message", "정상처리 되었습니다.");
		return new ModelAndView(this.success, map);
	}
	
	public void setLoanService(ILoanService loanService) {
		this.loanService = loanService;
	}
}
