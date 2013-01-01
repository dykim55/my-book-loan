package com.company.book.book;

import java.sql.SQLException;
import java.util.List;

import org.springframework.web.servlet.ModelAndView;

import com.company.book.dto.BookInfoDTO;
import com.company.framework.utils.DateUtil;
import com.company.util.Utils;
import com.ibatis.sqlmap.client.SqlMapClient;

public class BookService implements IBookService {
	
	private SqlMapClient connection;

	@SuppressWarnings("unchecked")
	public List<BookInfoDTO> searchBookInfo(BookInfoDTO dto) throws Exception {
		dto.searchRowCount(connection, "book.selectBookInfo-count");
		return connection.queryForList("book.selectBookInfo", dto);
	}

	@SuppressWarnings("unchecked")
	public List<BookInfoDTO> searchBookInfoName(BookInfoDTO dto) throws Exception {
		return connection.queryForList("book.selectBookInfoName", dto);
	}
	
	public String getNextBookNo() throws Exception {
		return (String)connection.queryForObject("book.getNextBookNo");
	}
	
	public void insertBookInfo(BookInfoDTO dto) throws Exception {
		
		String strBookNo = "";
		String strCurrentDate = DateUtil.getYYYYMMDDHH24MISS();
		
		try {
			dto.setM_area(dto.getSessionData().getArea());
			
			int nBuyCount = Integer.parseInt(dto.getM_buy_cnt());
			for (int i = 0; i < nBuyCount; i++) {
				if (dto.getM_book_no() == null || dto.getM_book_no().isEmpty()) {
					strBookNo = Utils.addLeadingCharacter(getNextBookNo(), '0', 6);
					dto.setM_book_no(strBookNo);
					dto.setM_reg_dt(strCurrentDate);
					dto.setM_reg_id(dto.getSessionData().getUserId());
				}

				if (dto.getM_buy_dt() != null) {
					dto.setM_buy_dt(dto.getM_buy_dt().replace("-", ""));
				}
				
				dto.setM_mdf_dt(strCurrentDate);
				dto.setM_mdf_id(dto.getSessionData().getUserId());
				
				int applyCnt = connection.update("book.updateBookInfo", dto);
				if (applyCnt < 1) {
					connection.insert("book.insertBookInfo", dto);
				}
				
				dto.setM_book_no("");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
		} finally {
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<BookInfoDTO> searchBookInfoExcel(BookInfoDTO dto) throws Exception {
		return connection.queryForList("book.selectBookInfoExcel", dto);
	}
	
	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
}
