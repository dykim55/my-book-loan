package com.cyberone.report.interceptor;

import java.util.Date;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.cyberone.report.model.UserInfo;

public class HttpSessionMonitor implements HttpSessionListener {
    public void sessionCreated(HttpSessionEvent event) {
        System.out.printf("Session ID %s ( timeout: %s ) created at %s%n", event.getSession().getId(), event.getSession().getMaxInactiveInterval(), new Date());
    }
    public void sessionDestroyed(HttpSessionEvent event) {
    	
    	UserInfo userInfo = (UserInfo)event.getSession().getAttribute("userInfo");
    	
    	try { userInfo.getPromDb().getMongo().close(); } catch (Exception e) { e.printStackTrace(); }
    	try { userInfo.getReportDb().getMongo().close(); } catch (Exception e) { e.printStackTrace(); }
    	
    	System.out.println("LoginID: " + userInfo.getAdmin().getAdminName());
        System.out.printf("Session ID %s ( timeout: %s ) destroyed at %s%n", event.getSession().getId(), event.getSession().getMaxInactiveInterval(), new Date());

        
        
        
        
    
        
    
    }
}
