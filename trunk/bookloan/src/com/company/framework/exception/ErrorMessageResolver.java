package com.company.framework.exception;

import java.util.ResourceBundle;

/**
 * 에러메시지를 처리하기 위한 message resolver
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2007. 12. 27
 * <br>
 */
public class ErrorMessageResolver implements IMessageResover {
	/** message를 정의한 bundle */
	protected	ResourceBundle	bundle	= null;
	
	protected	String			bundleName	= null;
	
	/**
	 * 
	 * @param bundleName message를 가져올 bundle의 경로
	 */
	public ErrorMessageResolver(String bundleName) {
		this.bundleName	= bundleName;
		this.bundle	= ResourceBundle.getBundle(bundleName);
	}
	
	public ErrorMessageResolver() {}
	
	public String getBundleName() {
		return bundleName;
	}

	public void setBundleName(String bundleName) {
		this.bundleName = bundleName;
		this.bundle	= ResourceBundle.getBundle(bundleName);
	}

	public void setBundle(ResourceBundle bundle) {
		this.bundle = bundle;
	}

	public ResourceBundle getBundle() {
		return this.bundle;
	}

	/**
	 * code에 해당하는 message를 가져온다.
	 */
	public String getMessage(String code) {
		return this.bundle.getString(code);
	}
}