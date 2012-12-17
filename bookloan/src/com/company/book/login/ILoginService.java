package com.company.book.login;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.company.card.dto.UsrDTO;

/**
 * @author
 * 
 */
public interface ILoginService {

	public List<UsrDTO> login(UsrDTO dto) throws Exception;
	
	public void logout(HttpSession session) throws Exception;

}
