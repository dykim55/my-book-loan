package com.company.card.sample;

import java.util.List;

import com.company.card.dto.SearchIssueDTO;

/**
 * @author
 * 
 */
public interface ISampleService {

	public List<SearchIssueDTO> sampleSearch(SearchIssueDTO dto) throws Exception;
	
}
