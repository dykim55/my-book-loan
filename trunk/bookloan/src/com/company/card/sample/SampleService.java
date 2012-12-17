package com.company.card.sample;

import java.util.List;

import com.company.card.dto.SearchIssueDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class SampleService implements ISampleService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<SearchIssueDTO> sampleSearch(SearchIssueDTO dto) throws Exception {
		dto.searchRowCount(connection, "sample.getIssueList-count");
		return connection.queryForList("sample.getIssueList", dto);
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
