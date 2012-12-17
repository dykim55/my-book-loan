package com.company.book.sample;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.card.dto.SearchIssueDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class SampleController extends SIVController {

	private ISampleService sampleService;
	
	public ModelAndView sampleView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	/**
	 * 직원증발급이력 조회
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView sampleSearch(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		SearchIssueDTO dto = (SearchIssueDTO) DataUtils.dtoBuilder(req, SearchIssueDTO.class);
		dto.setSessionData(req);
		
		List<SearchIssueDTO> list = sampleService.sampleSearch(dto);
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public void setSampleService(ISampleService sampleService) {
		this.sampleService = sampleService;
	}
}
