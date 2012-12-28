package com.company.book.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.UserSessionManager;
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
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());

		if (dto.getM_birth_dt() != null) {
			dto.setM_birth_dt(dto.getM_birth_dt().replace("-", ""));
		}
		
		List<MemberInfoDTO> list = null;
		
		list = memberService.searchMemberInfo(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView registrationMember(HttpServletRequest req, HttpServletResponse res) throws Exception {

		ModelMap map = new ModelMap();
		
		MemberInfoDTO dto = (MemberInfoDTO) DataUtils.dtoBuilder(req, MemberInfoDTO.class);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());
		
		String strMno = "";
		String strCurrentDate = DateUtil.getYYYYMMDDHH24MISS();
		if (dto.getM_no() == null || dto.getM_no().isEmpty()) {
			strMno = Utils.addLeadingCharacter(memberService.getNextMemberNo(), '0', 6);
			if (strMno.length() != 6) {
				map.addAttribute("err_code", "0001");
				map.addAttribute("err_message", "회원번호를 생성하지 못했습니다. 관리자에게 문의하세요.");
				return new ModelAndView(this.success, map);
			}
			dto.setM_no(strMno);
			
			dto.setM_entry_dt(strCurrentDate);
			dto.setM_reg_dt(strCurrentDate);
			dto.setM_reg_id(session.getUserId());
		}
		
		if (dto.getM_birth_dt() != null) {
			dto.setM_birth_dt(dto.getM_birth_dt().replace("-", ""));
		}
		if (dto.getM_tel_no() != null) {
			dto.setM_tel_no(dto.getM_tel_no().replace("-", ""));
		}
		if (dto.getM_cell_no() != null) {
			dto.setM_cell_no(dto.getM_cell_no().replace("-", ""));
		}

		dto.setM_mbr_cd("1");
		dto.setM_mdf_dt(strCurrentDate);
		dto.setM_mdf_id(session.getUserId());
		
		memberService.insertMemberInfo(dto);
		
		map.addAttribute("err_code", "0000");
		map.addAttribute("err_message", "정상처리 되었습니다.");
		return new ModelAndView(this.success, map);
	}
	
	public void setMemberService(IMemberService memberService) {
		this.memberService = memberService;
	}
}
