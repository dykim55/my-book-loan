package com.company.book.member;

import java.util.List;

import com.company.card.dto.MfcBasDTO;
import com.company.card.dto.SearchIssueHistDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class MemberService implements IMemberService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<SearchIssueHistDTO> searchStudentIssueList(SearchIssueHistDTO dto) throws Exception {
		dto.searchRowCount(connection, "search.selectStudentIssueList-count");
		return connection.queryForList("search.selectStudentIssueList", dto);
	}

	public MfcBasDTO shwoDetailInfo(MfcBasDTO dto) throws Exception {
		return (MfcBasDTO)connection.queryForObject("search.shwoDetailInfo", dto);
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
