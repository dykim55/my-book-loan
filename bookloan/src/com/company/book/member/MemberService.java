package com.company.book.member;

import java.sql.SQLException;
import java.util.List;

import com.company.book.dto.MemberInfoDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

public class MemberService implements IMemberService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<MemberInfoDTO> searchMemberInfo(MemberInfoDTO dto) throws Exception {
		return connection.queryForList("member.selectMemberInfo", dto);
	}

	@SuppressWarnings("unchecked")
	public List<MemberInfoDTO> searchMemberInfoName(MemberInfoDTO dto) throws Exception {
		return connection.queryForList("member.selectMemberInfoName", dto);
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
