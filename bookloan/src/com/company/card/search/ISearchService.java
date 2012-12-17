package com.company.card.search;

import java.util.List;

import com.company.card.dto.MfcBasDTO;
import com.company.card.dto.SearchIssueHistDTO;

/**
 * @author
 * 
 */
public interface ISearchService {

	public List<SearchIssueHistDTO> searchStudentIssueList(SearchIssueHistDTO dto) throws Exception;
	
	public MfcBasDTO shwoDetailInfo(MfcBasDTO dto) throws Exception;
}
