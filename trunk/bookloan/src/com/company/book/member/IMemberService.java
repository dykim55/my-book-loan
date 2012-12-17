package com.company.book.member;

import java.util.List;

import com.company.card.dto.MfcBasDTO;
import com.company.card.dto.SearchIssueHistDTO;

/**
 * @author
 * 
 */
public interface IMemberService {

	public List<SearchIssueHistDTO> searchStudentIssueList(SearchIssueHistDTO dto) throws Exception;
	
	public MfcBasDTO shwoDetailInfo(MfcBasDTO dto) throws Exception;
}
