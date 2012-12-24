package com.company;


/**
 * 유저 세션
 * @author Administrator
 *
 */
public class UserSession  {

	private String strUserId;
	private String strArea;
	
	public String getUserId() {
		return strUserId;
	}
	
	public void setUserId(String id) {
		this.strUserId = id;
	}

	public String getArea() {
		return strArea;
	}
	
	public void setArea(String strArea) {
		this.strArea = strArea;
	}
	
}
