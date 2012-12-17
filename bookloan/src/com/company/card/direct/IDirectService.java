package com.company.card.direct;

import java.util.List;

import com.company.card.dto.DirectIssueInfoDTO;

/**
 * @author
 * 
 */
public interface IDirectService {

	public List<DirectIssueInfoDTO> searchStudentInfo(DirectIssueInfoDTO dto) throws Exception;
	
	public List<DirectIssueInfoDTO> searchStudentInfoName(DirectIssueInfoDTO dto) throws Exception;

	public List<DirectIssueInfoDTO> searchStaffIssueInfo(DirectIssueInfoDTO dto) throws Exception;
	
}
