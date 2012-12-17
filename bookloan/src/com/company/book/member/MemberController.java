package com.company.book.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.card.dto.MfcBasDTO;
import com.company.card.dto.SearchIssueHistDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class MemberController extends SIVController {

	private IMemberService searchService;
	
	public ModelAndView searchStudentIssueView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	/**
	 * 학생증발급이력 조회
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView searchStudentIssueList(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		SearchIssueHistDTO dto = (SearchIssueHistDTO) DataUtils.dtoBuilder(req, SearchIssueHistDTO.class);
		dto.setSessionData(req);
		
		List<SearchIssueHistDTO> list = searchService.searchStudentIssueList(dto);
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}

	/**
	 * 학생상세정보 조회
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView shwoDetailInfo(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		MfcBasDTO dto = (MfcBasDTO) DataUtils.dtoBuilder(req, MfcBasDTO.class);
		dto.setSessionData(req);
		
		dto = searchService.shwoDetailInfo(dto);
		ModelMap map = new ModelMap();
		map.addAttribute("detail", dto);
		
		return new ModelAndView(this.success, map);
	}
	
	public void setSearchService(IMemberService searchService) {
		this.searchService = searchService;
	}
}
