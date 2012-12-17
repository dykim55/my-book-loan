package com.company.framework.beans;

import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import com.company.framework.logic.IPageable;

/**
 * web application에서 list를 처리하기 위한 list collection.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2007. 12. 27
 * <br>
 */
public class SIVList
{
	/**
	 * siv_config.properties에 DEFAULT_ROWNUM이 선언되지 않거나 유효하지 않은 값일 경우	사용.
	 */
	public static final int		DEFAULT_ROWNUM		= 10;
	
	/**
	 * siv_config.propertis에 DEFAULT_PAGE_BLOCK이 선언되지 않거나 유효하지 않을 값일 경우 사용.
	 */
	public static final int		DEFAULT_PAGE_BLOCK	= 10;
	
	/** 
	 * 페이지 당 게시물 개수를 표현한다. 페이지당 게시물 개수를 달리하고 싶으면 이 값을 수정한다.
	 * @see <code>getRowNum()</code>
	 * @see <code>setRowNum(int num)</code>
	 */
	protected int			rowNum;
	
	/**
	 * 표현할 페이지(링크)의 개수를 설정한다.
	 */
	protected int			pageBlock;
	
	/** 게시물 목록 */
	protected	List<ArrayList<Object>> list = null;
	
	/** 전체 게시물 수 */
	protected	long		totalSize	= -1;
	
	/** 현재 페이지 번호 */
	protected	int			pageNo		= 1;
	
	/**
	 * totalSize가 설정되었는가를 표현한다. 설정되어 있지 않은 경우 getTotalSize()를 호출하면 예외발생.<p>
	 */
	protected	boolean settedTotalSize		= false;
	
	/**
	 * list가 설정되었는가를 표현한다. 설정되어 있지 않은 경우 getList()를 호출하면 예외발생.<p>
	 */
	protected	boolean	settedList			= false;
	
	/**
	 * pageNo가 설정되었는지를 표현한다. 설정되어 있지 않은 경우 getPageNo()를 호출하면 예외발생.<p>
	 */
	protected	boolean	settedPageNo		= false;
	
	/**
	 * 생성자. 
	 * 
	 * @param logic logic은 rowNum과 pageBlock 정보를 가지고 있는 비즈니스 로직. 만일 값이 없다면 siv_config.properties 파일내의 DEFAULT_ROWNUM, DEFAULT_PAGE_BLOCK을 사용하며 siv_config.properties에서도 내용을 찾을 수 없으면 각각 10, 10으로 초기화 한다. 
	 */
	public SIVList(IPageable logic) {
		// rownum 설정
		try {
			this.rowNum	= logic.getRowNum();
			if (rowNum == 0) {
				try {
					ResourceBundle	bundle	= ResourceBundle.getBundle("siv_config");
					rowNum	= Integer.parseInt(bundle.getString("DEFAULT_ROWNUM"));
				} catch (Exception e1) {
					rowNum	= DEFAULT_ROWNUM;
				}
			}
		} catch (Exception e) {
			rowNum	= DEFAULT_ROWNUM;
			e.printStackTrace();
		}
		
		// pageBlock 설정
		try {
			this.pageBlock	= logic.getPageBlock();
			
			if (this.pageBlock == 0) {
				try {
					ResourceBundle	bundle	= ResourceBundle.getBundle("siv_config");
					this.pageBlock	= Integer.parseInt(bundle.getString("DEFAULT_PAGE_BLOCK"));
				} catch (Exception e1) {
					this.pageBlock	= DEFAULT_PAGE_BLOCK;
				}
			}
		} catch (Exception e) {
			this.pageBlock	= DEFAULT_PAGE_BLOCK;
			e.printStackTrace();
		}
	}
	
	/**
	 * 행수 반환.<p>
	 * 
	 * @return rowNum<p>
	 */
	public int getRowNum()
	{
		return rowNum;
	}

	/**
	 * 실제 목록이 들어있는 collection을 반환.<p>
	 * 
	 * @return ArrayList
	 * @throws IllegalStateException setList가 호출되지 않음.
	 * @see <code>setList(ArrayList list)<code>
	 */
	public List<ArrayList<Object>> getList() throws IllegalStateException
	{
		if (!settedList) 
			throw new IllegalStateException("setList(ArrayList list) method must be invoked before getList invocation.");
		return list;
	}

	/**
	 * 현재 등록되어 있는 게시물의 총개수를 반환.<p>
	 * 이 메소드가 호출되기 이전에 setTotalSize(int i)가 먼저 호출되어야 한다.<p>
	 * 
	 * @return 현재 검색된 게시물의 총개수.<p>
	 * @throws IllegalStateException setTotalSize(int i)가 호출되지 않음.
	 * @see <code>setTotalSize(long i)</code>
	 */
	public long getTotalSize() throws IllegalStateException
	{
		if (!settedTotalSize) 
			throw new IllegalStateException("setTotalSize(int i) method must be invoked before getTotalSize invocation.");
		return totalSize;
	}

	/**
	 * list를 setting.<p>
	 * 
	 * @param list
	 */
	public void setList(List<ArrayList<Object>> list)
	{
		settedList	= true;
		this.list = list;
	}

	/**
	 * 검색된 모든 게시물 수를 setting.<p>
	 * 
	 * @param i 검색된 총 게시물 수.
	 */
	public void setTotalSize(long i )
	{
		this.settedTotalSize	= true;
		totalSize = i;
	}
	
	/** 
	 * startPage부터 pageBlock개를 계산한다.<p>
	 *
	 * @return 페이징 해야할 마지막 페이지번호. 현재 pageNo가 시작 pageNo ~ pageBlock 라면 시작 pageNo + pageBlock을 반환한다.
	 */
	public int getLastPage()
	{
		int	lastPage	= getStartPage() + pageBlock - 1;
		if (lastPage > getMaxPage()) return getMaxPage();
		
		return lastPage;
	}
	
	/**
	 * 검색된 총 게시물의 개수에 대한 총 페이지수를 환산한다.<p>
	 * 
	 * @return 검색된 총 게시물수에 대한 총 페이지 수.<p>
	 */
	public int getMaxPage()
	{
		int	maxPage	= (int)((totalSize + rowNum - 1) / rowNum);
		maxPage	= maxPage < 1 ? 1 : maxPage;
		return maxPage;
	}
	
	/**
	 * 시작 페이지 번호를 반환.<p>
	 * 
	 * @return pageNo가 시작 pageNo ~ 시작 pageNo + pageBlock 사이라면 시작 pageNo를 반환.<p>
	 */
	public int getStartPage()
	{
		return ((pageNo - 1) / pageBlock) * pageBlock + 1;
	}
	
	/**
	 * 게시물 시작번호(카운트)<p>
	 * 
	 * @return 총 게시물에 대한 현재 게시물의 offset.<p>
	 */
	public long getStartNo()
	{
		long	startNo	= totalSize - (pageNo - 1) * rowNum; 
		return startNo;
	}
	
	/**
	 * 읽어올 게시물 목록의 offset
	 * 
	 * @return long
	 */
	public long getOffset()
	{
		return (pageNo - 1) * rowNum;
	}

	/**
	 * 현재 페이지 번호 반환.<p>
	 * 
	 * @return 현재 페이지 번호.<p>
	 * @throws IllegalStateException setPageNo(int i)가 호출되지 않음.<p>
	 */
	public int getPageNo() throws IllegalStateException
	{
		if (!settedPageNo)
			throw new IllegalStateException("setPageNo(int i) method must be invoked before getPageNo invocation.");
		return pageNo;
	}

	/**
	 * 선택된 pageNo를 set.
	 * 
	 * @param i
	 */
	public void setPageNo(int i)
	{
		this.settedPageNo	= true;
		pageNo = i;
	}
}
