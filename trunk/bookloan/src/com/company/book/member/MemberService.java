package com.company.book.member;

import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class MemberService implements IMemberService {
	
	private SqlMapClient connection;

	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
