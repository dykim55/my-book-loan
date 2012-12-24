package com.company.book.book;

import java.sql.SQLException;
import java.util.List;

import com.company.book.dto.MemberInfoDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class BookService implements IBookService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<MemberInfoDTO> searchMemberInfo(MemberInfoDTO dto) throws Exception {
		dto.searchRowCount(connection, "member.selectMemberInfo-count");
		return connection.queryForList("member.selectMemberInfo", dto);
	}

	@SuppressWarnings("unchecked")
	public List<MemberInfoDTO> searchMemberInfoName(MemberInfoDTO dto) throws Exception {
		return connection.queryForList("member.selectMemberInfoName", dto);
	}
	
	public String getNextMemberNo() throws Exception {
		return (String)connection.queryForObject("member.getNextMemberNo");
	}
	
	public void insertMemberInfo(MemberInfoDTO dto) throws Exception {
		try {
			int applyCnt = connection.update("member.updateMemberInfo", dto);
			if (applyCnt < 1) {
				connection.insert("member.insertMemberInfo", dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
		}
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
