package com.company.card.dto;

public class DirectIssueInfoDTO extends PagingBean {

	private String bas_idno;
	private String bas_name;

	public String getBas_idno() {
		return bas_idno;
	}
	public void setBas_idno(String bas_idno) {
		this.bas_idno = bas_idno;
	}
	public String getBas_name() {
		return bas_name;
	}
	public void setBas_name(String bas_name) {
		this.bas_name = bas_name;
	}
	
}
