package com.company.book.login;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.company.book.dto.MngInfoDTO;


/**
 * @author
 * 
 */
public interface ILoginService {

	public List<MngInfoDTO> login(MngInfoDTO dto) throws Exception;
	
	public void logout(HttpSession session) throws Exception;

}
