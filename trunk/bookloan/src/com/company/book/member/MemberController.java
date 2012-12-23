package com.company.book.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.book.dto.MemberInfoDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.framework.utils.DateUtil;
import com.company.util.DataUtils;
import com.company.util.Utils;

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
		
		list = memberService.searchMemberInfo(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView registrationMember(HttpServletRequest req, HttpServletResponse res) throws Exception {

		ModelMap map = new ModelMap();
		
		MemberInfoDTO dto = (MemberInfoDTO) DataUtils.dtoBuilder(req, MemberInfoDTO.class);
		
		UserSession session = (UserSession)req.getSession().getAttribute("session-user");
		
		String strMno = "";
		if (dto.getM_no() == null || dto.getM_no().isEmpty()) {
			strMno = Utils.addLeadingCharacter(memberService.getNextMemberNo(), '0', 6);
		}
		
		if (strMno.length() != 6) {
			map.addAttribute("err_code", "0001");
			map.addAttribute("err_message", "회원번호를 생성하지 못했습니다. 관리자에게 문의하세요.");
			return new ModelAndView(this.success, map);
		}
		
		dto.setM_reg_dt(DateUtil.getYYYYMMDDHH24MISS());
		dto.setM_reg_id(session.getUserId());
		dto.setM_mdf_dt(dto.getM_reg_dt());
		dto.setM_mdf_id(dto.getM_reg_id());
		
		//memberService.insertMemberInfo(dto);
		
		map.addAttribute("err_code", "0000");
		map.addAttribute("err_message", "정상처리 되었습니다.");
		return new ModelAndView(this.success, map);
	}
	
	public void setMemberService(IMemberService memberService) {
		this.memberService = memberService;
	}
}
