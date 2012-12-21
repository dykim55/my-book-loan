package com.company.book.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.book.dto.MemberInfoDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.framework.utils.DateUtil;
import com.company.util.DataUtils;

/**
 * @author
 * 
 */
public class MemberController extends SIVController {

	private IMemberService memberService;
	
	public ModelAndView memberView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	public ModelAndView searchMemberInfo( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//학생정보 조회		
		MemberInfoDTO dto = (MemberInfoDTO) DataUtils.dtoBuilder(req, MemberInfoDTO.class);
		dto.setSessionData(req);

		List<MemberInfoDTO> list = null;
		if (dto.getM_no() != null && dto.getM_no().length() > 0) {
			list = memberService.searchMemberInfo(dto);
		}
		else if (dto.getM_name() != null && dto.getM_name().length() > 0) {
			list = memberService.searchMemberInfoName(dto);
			if (list.size() == 1) {
				MemberInfoDTO rowData = list.get(0);
				dto.setM_no(rowData.getM_no());
				list = memberService.searchMemberInfo(dto);
			}
		}
		
		ModelMap map =  dto.createModelMap(list);
		if (list.size() > 0) {
			req.setAttribute("resultList", list);
			req.setAttribute("count", list.size());	//조회 성공여부 확인
		} else {
	    	req.setAttribute("result", "error");
	    	req.setAttribute("result_message", "조회된 정보가 없습니다.");
	    	req.setAttribute("count", 0);	//조회 성공여부 확인
		}
		
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView registrationMember(HttpServletRequest req, HttpServletResponse res) throws Exception {

		MemberInfoDTO dto = (MemberInfoDTO) DataUtils.dtoBuilder(req, MemberInfoDTO.class);
		
		UserSession session = (UserSession)req.getSession().getAttribute("session-user");
		
		dto.setM_reg_id(session.getUserId());
		dto.setM_mdf_id(session.getUserId());
		dto.setM_reg_dt(DateUtil.getYYYYMMDDHH24MISS());
		dto.setM_mdf_dt(dto.getM_reg_dt());
		
		memberService.insertMemberInfo(dto);
		
		ModelMap map = new ModelMap();
		map.addAttribute("idno", dto.getM_no());
		
		return new ModelAndView(this.success, map);
	}
	
	public void setMemberService(IMemberService memberService) {
		this.memberService = memberService;
	}
}
