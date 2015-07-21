package com.cyberone.report.model;

import com.mongodb.DB;

/**
 * 계정정보
 *
 */
public class UserInfo {

	private Admin admin;
	private int domainCode;
	private transient DB promDb;
	private transient DB reportDb;
	
	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public int getDomainCode() {
		return domainCode;
	}

	public void setDomainCode(int domainCode) {
		this.domainCode = domainCode;
	}

	public DB getPromDb() {
		return promDb;
	}

	public void setPromDb(DB promDb) {
		this.promDb = promDb;
	}

	public DB getReportDb() {
		return reportDb;
	}

	public void setReportDb(DB reportDb) {
		this.reportDb = reportDb;
	}
	
	
}
