package com.company.book.dto;

public class CodeDTO extends PagingBean {

	//테이블 컬럼명
    private String code_group_cd; 
    private String code_group_name; 
    private String code_cd; 
    private String code_name; 
    private String code_desc;
    
	public String getCode_group_cd() {
		return code_group_cd;
	}
	public void setCode_group_cd(String code_group_cd) {
		this.code_group_cd = code_group_cd;
	}
	public String getCode_group_name() {
		return code_group_name;
	}
	public void setCode_group_name(String code_group_name) {
		this.code_group_name = code_group_name;
	}
	public String getCode_cd() {
		return code_cd;
	}
	public void setCode_cd(String code_cd) {
		this.code_cd = code_cd;
	}
	public String getCode_name() {
		return code_name;
	}
	public void setCode_name(String code_name) {
		this.code_name = code_name;
	}
	public String getCode_desc() {
		return code_desc;
	}
	public void setCode_desc(String code_desc) {
		this.code_desc = code_desc;
	} 

    
}
