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

	private int rows;		//페이지당 Row 수
	private int records;	//전체 레코드 수
	private int total;		//전체 페이지 수
	private int page;		//현재 페이지

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
		
		map.addAttribute("rows", list);
		map.addAttribute("page", page);
		map.addAttribute("rowNum", rows);
		map.addAttribute("total", total);
		map.addAttribute("records", records);
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
		records = bean.records;
		total += (records/rows) + ((records%rows > 0) ? 1 : 0);
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
	
	public int getPage() {
		return page;
	}
	
	public void setPage(int page) {
		this.page = page;
	}

	public int getRecords() {
		return records;
	}
	public void setRecords(int records) {
		this.records = records;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
}
