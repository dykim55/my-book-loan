package com.company.book.book;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import com.company.UserSession;
import com.company.UserSessionManager;
import com.company.book.dto.BookInfoDTO;
import com.company.framework.mvc.controller.SIVController;
import com.company.framework.utils.DateUtil;
import com.company.util.DataUtils;
import com.company.util.Utils;

/**
 * @author
 * 
 */
public class BookController extends SIVController {

	private IBookService bookService;
	
	public ModelAndView bookView(HttpServletRequest req, HttpServletResponse res) throws Exception {
		return new ModelAndView(this.success);
	}

	public ModelAndView searchBookInfo( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		BookInfoDTO dto = (BookInfoDTO) DataUtils.dtoBuilder(req, BookInfoDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());
		
		List<BookInfoDTO> list = null;
		
		list = bookService.searchBookInfo(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public ModelAndView registrationBook(HttpServletRequest req, HttpServletResponse res) throws Exception {

		ModelMap map = new ModelMap();
		
		BookInfoDTO dto = (BookInfoDTO) DataUtils.dtoBuilder(req, BookInfoDTO.class);
		dto.setSessionData(req);
		
		if (dto.getM_book_no() == null || dto.getM_book_no().isEmpty()) {
			map.addAttribute("save_type", "I");
		} else {
			map.addAttribute("save_type", "U");
		}
		
		try { 
			bookService.insertBookInfo(dto);
		} catch (Exception e) {
			map.addAttribute("err_code", "0002");
			map.addAttribute("err_message", "도서정보 등록 중 오류가 발생했습니다.");
			return new ModelAndView(this.success, map);
		}
		
		map.addAttribute("err_code", "0000");
		map.addAttribute("err_message", "정상처리 되었습니다.");
		return new ModelAndView(this.success, map);
	}

	public ModelAndView searchBookInfoExcel( HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		BookInfoDTO dto = (BookInfoDTO) DataUtils.dtoBuilder(req, BookInfoDTO.class);
		dto.setSessionData(req);
		
		UserSession session = UserSessionManager.getUserSession(req);
		dto.setM_area(session.getArea());
		
		List<BookInfoDTO> list = null;
		
		list = bookService.searchBookInfoExcel(dto);
		
		ModelMap map =  dto.createModelMap(list);
		
		return new ModelAndView(this.success, map);
	}
	
	public void setBookService(IBookService bookService) {
		this.bookService = bookService;
	}
}
