package com.company.book.member;

import java.util.List;

import com.company.book.dto.MemberInfoDTO;


/**
 * @author
 * 
 */
public interface IMemberService {
	
	public void insertMemberInfo(MemberInfoDTO dto) throws Exception;

	public List<MemberInfoDTO> searchMemberInfo(MemberInfoDTO dto) throws Exception;
	
	public List<MemberInfoDTO> searchMemberInfoName(MemberInfoDTO dto) throws Exception;
	
	public String getNextMemberNo() throws Exception;
	
	public List<MemberInfoDTO> searchMemberInfoExcel(MemberInfoDTO dto) throws Exception;
}
