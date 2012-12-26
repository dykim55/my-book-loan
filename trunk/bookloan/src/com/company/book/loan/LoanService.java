package com.company.book.loan;

import java.sql.SQLException;
import java.util.List;

import com.company.book.dto.BookInfoDTO;
import com.company.book.dto.LoanHistoryDTO;
import com.company.book.dto.MemberInfoDTO;
import com.company.framework.utils.DateUtil;
import com.ibatis.sqlmap.client.SqlMapClient;

public class LoanService implements ILoanService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<MemberInfoDTO> searchMemberInfo(MemberInfoDTO dto) throws Exception {
		return connection.queryForList("loan.selectMemberInfo", dto);
	}

	@SuppressWarnings("unchecked")
	public List<BookInfoDTO> searchBookInfo(BookInfoDTO dto) throws Exception {
		return connection.queryForList("loan.selectBookInfo", dto);
	}
	
	@SuppressWarnings("unchecked")
	public List<LoanHistoryDTO> searchLoanHistory(LoanHistoryDTO dto) throws Exception {
		dto.searchRowCount(connection, "loan.selectLoanHistory-count");
		return connection.queryForList("loan.selectLoanHistory", dto);
	}
	
	public void insertLoanHistory(LoanHistoryDTO dto) throws Exception {
		
		String strCurrentDate = DateUtil.getYYYYMMDDHH24MISS();
		
		try {
			dto.setM_area(dto.getSessionData().getArea());
			dto.setM_loan_dt(strCurrentDate);
			dto.setM_reg_dt(strCurrentDate);
			dto.setM_reg_id(dto.getSessionData().getUserId());
			dto.setM_mdf_dt(strCurrentDate);
			dto.setM_mdf_id(dto.getSessionData().getUserId());
			connection.insert("loan.insertLoanHistory", dto);

			int applyCnt = connection.update("loan.updateBookInfo", dto);
			
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
