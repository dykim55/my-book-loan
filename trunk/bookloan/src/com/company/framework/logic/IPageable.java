package com.company.framework.logic;


/**
 * 비즈니스 로직과 컨트롤러간의 interaction에 사용하는 interface.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2006. 9. 15.
 * <br>
 */
public interface IPageable {

	/** 
	 * 페이지 당 게시물 개수를 반환한다.
	 */
	public int getRowNum();
	
	/**
	 * 페이지 당 게시물 개수를 설정한다.
	 * 
	 * @param rownum
	 */
	public void setRowNum(int rownum);
	
	/**
	 * 표현할 페이지 개수를 반환한다.
	 * 
	 * @return
	 */
	public int getPageBlock();
	
	/**
	 * 표현할 페이지 개수를 설정한다.
	 * 
	 * @param pageBlock
	 */
	public void setPageBlock(int pageBlock);
}