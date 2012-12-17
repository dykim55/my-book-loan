package com.company.card.direct;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.card.batch.IBatchService;
import com.company.card.common.ICommonService;
import com.company.card.dto.DirectIssueInfoDTO;
import com.company.card.dto.MfcSavDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.util.DataUtils;


/**
 * @author
 * 
 */
public class DirectController extends SIVController {
	
	/* ======================================================
	 * 속성 선언부
	 ====================================================== */
	private IDirectService directService;
	private IBatchService batchService;
	private ICommonService commonService;
	
	/* ======================================================
	 * 메소드 구현부
	 ====================================================== */
	public ModelAndView studentIssueView(HttpServletRequest req, HttpServletResponse res) {
		return new ModelAndView(this.success);
	}

	public ModelAndView staffIssueView(HttpServletRequest req, HttpServletResponse res) {
		return new ModelAndView(this.success);
	}
	
	/**
	 * 직원정보 조회
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView searchStudentIssueInfo( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		//일괄발급내역에 등록이 되어있는지 체크
		MfcSavDTO savDto = (MfcSavDTO) DataUtils.dtoBuilder(req, MfcSavDTO.class);
		
		if (savDto.getSav_idno() != null && savDto.getSav_idno().length() > 0) {
//			List<MfcSavDTO> savList = batchService.searchBatchSaveInfo(savDto);
//			if (savList.size() > 0) {
//				req.setAttribute("count", 0);
//		    	req.setAttribute("result", "error");
//		    	req.setAttribute("result_message", "이미 일괄발급대상자에 등록되어 있습니다.");
//		    	return new ModelAndView(this.success);
//			}
		}
		
		//학생정보 조회		
		DirectIssueInfoDTO dto = (DirectIssueInfoDTO) DataUtils.dtoBuilder(req, DirectIssueInfoDTO.class);

		List<DirectIssueInfoDTO> list = null;
		if (dto.getBas_idno() != null && dto.getBas_idno().length() > 0) {
			list = directService.searchStudentInfo(dto);
		}
		else if (dto.getBas_name() != null && dto.getBas_name().length() > 0) {
			list = directService.searchStudentInfoName(dto);
			if (list.size() == 1) {
				DirectIssueInfoDTO rowData = list.get(0);
				dto.setBas_idno(rowData.getBas_idno());
				list = directService.searchStudentInfo(dto);
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
	
	public ModelAndView searchStaffIssueInfo(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	/* ======================================================
	 * getters, setters 선언부
	 ====================================================== */
	public void setDirectService(IDirectService directService) {
		this.directService = directService;
	}

	public void setBatchService(IBatchService batchService) {
		this.batchService = batchService;
	}

	public void setCommonService(ICommonService commonService) {
		this.commonService = commonService;
	}
}
