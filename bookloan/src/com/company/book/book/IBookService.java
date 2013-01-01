package com.company.book.book;

import java.util.List;

import com.company.book.dto.BookInfoDTO;


/**
 * @author
 * 
 */
public interface IBookService {
	
	public void insertBookInfo(BookInfoDTO dto) throws Exception;

	public List<BookInfoDTO> searchBookInfo(BookInfoDTO dto) throws Exception;
	
	public List<BookInfoDTO> searchBookInfoName(BookInfoDTO dto) throws Exception;
	
	public String getNextBookNo() throws Exception;
	
	public List<BookInfoDTO> searchBookInfoExcel(BookInfoDTO dto) throws Exception;
}
