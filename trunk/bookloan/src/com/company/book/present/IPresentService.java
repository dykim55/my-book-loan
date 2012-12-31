package com.company.book.present;

import java.util.List;

import com.company.book.dto.LoanHistoryDTO;



/**
 * @author
 * 
 */
public interface IPresentService {
	
	public List<LoanHistoryDTO> searchLoanHistory(LoanHistoryDTO dto) throws Exception;
	
	public List<LoanHistoryDTO> searchRcvPresent(LoanHistoryDTO dto) throws Exception;

}
