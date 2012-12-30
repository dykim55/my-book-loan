package com.company.book.present;

import java.util.List;

import com.company.book.dto.LoanHistoryDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class PresentService implements IPresentService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<LoanHistoryDTO> searchLoanHistory(LoanHistoryDTO dto) throws Exception {
		dto.searchRowCount(connection, "present.selectLoanHistory-count");
		return connection.queryForList("present.selectLoanHistory", dto);
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
