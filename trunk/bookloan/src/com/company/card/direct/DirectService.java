package com.company.card.direct;

import java.util.List;

import com.company.card.dto.DirectIssueInfoDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class DirectService implements IDirectService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<DirectIssueInfoDTO> searchStudentInfo(DirectIssueInfoDTO dto) throws Exception {
		return connection.queryForList("issue.selectStaffInfo", dto);
	}

	@SuppressWarnings("unchecked")
	public List<DirectIssueInfoDTO> searchStudentInfoName(DirectIssueInfoDTO dto) throws Exception {
		return connection.queryForList("issue.selectStaffInfoName", dto);
	}
	
	@SuppressWarnings("unchecked")
	public List<DirectIssueInfoDTO> searchStaffIssueInfo(DirectIssueInfoDTO dto) throws Exception {
		return connection.queryForList("issue.selectStaffIssueInfo", dto);
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}

}
