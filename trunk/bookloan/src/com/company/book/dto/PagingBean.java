package com.company.book.dto;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.springframework.ui.ModelMap;

import com.company.UserSession;
import com.company.UserSessionManager;
import com.ibatis.sqlmap.client.SqlMapClient;

public class PagingBean {

	private int rowNum;
	private int totalCount;
	private int page;
	private int PAGING_RNUM;

	private UserSession session;
	
	/**
	 *  모델 맵 리턴
	 * @param list
	 * @return
	 */
	public ModelMap createModelMap(List<?> list){
		return createModelMap(list,null);
	}
	/**
	 * 모델 맵 리턴
	 * @param list
	 * @param map
	 * @return
	 */
	public ModelMap createModelMap(List<?> list,ModelMap map){
		if(map == null)map = new ModelMap();
		
		map.addAttribute("rowList", list);
		map.addAttribute("totalCount", totalCount);
		map.addAttribute("page", page);
		map.addAttribute("rowNum", rowNum);

		return map;
	}
	
	/**
	 * 페이지 카운터 조회
	 * @param connection
	 * @param alias
	 * @throws SQLException
	 */
	public void searchRowCount(SqlMapClient connection, String alias) throws SQLException {
		PagingBean bean = (PagingBean) connection.queryForObject(alias, this);
		totalCount = bean.totalCount;
	}
	
	
	/**
	 * 세션 디폴트 값 셋팅
	 * @param req
	 */
	public void setSessionData(HttpServletRequest req) {
		this.session = UserSessionManager.getUserSession(req);
	}
	
	public UserSession getSessionData() {
		return session;
	}
	
	/*
	 * DTO 데이터를 풀어서 출력
	 *  (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
	
	public int getRowNum() {
		return rowNum;
	}
	
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	public int getPage() {
		return page;
	}
	
	public void setPage(int page) {
		this.page = page;
	}
	
	public int getPAGING_RNUM() {
		return PAGING_RNUM;
	}

	public void setPAGING_RNUM(int pAGING_RNUM) {
		PAGING_RNUM = pAGING_RNUM;
	}
}
