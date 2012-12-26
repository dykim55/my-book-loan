package com.company.book.loan;

import java.util.List;

import com.company.book.dto.BookInfoDTO;
import com.company.book.dto.LoanHistoryDTO;
import com.company.book.dto.MemberInfoDTO;



/**
 * @author
 * 
 */
public interface ILoanService {
	
	public List<MemberInfoDTO> searchMemberInfo(MemberInfoDTO dto) throws Exception;
	
	public List<BookInfoDTO> searchBookInfo(BookInfoDTO dto) throws Exception;
	
	public List<LoanHistoryDTO> searchLoanHistory(LoanHistoryDTO dto) throws Exception;
	
	public void insertLoanHistory(LoanHistoryDTO dto) throws Exception;

}
