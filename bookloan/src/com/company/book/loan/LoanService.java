package com.company.book.loan;

import com.ibatis.sqlmap.client.SqlMapClient;

public class LoanService implements ILoanService {
	
	private SqlMapClient connection;

	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
