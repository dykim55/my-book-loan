package com.company.book.login;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.company.book.dto.MngInfoDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class LoginService implements ILoginService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<MngInfoDTO> login(MngInfoDTO dto) throws Exception {
		// 1. 사이트 관리자/운영자 여부 확인
		return connection.queryForList("login.selectLoginInfo", dto);
	}
	
	public void logout(HttpSession session) throws Exception {
		if (session != null) session.invalidate();
	}

	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
