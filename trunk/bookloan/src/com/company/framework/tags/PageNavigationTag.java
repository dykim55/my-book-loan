package com.company.framework.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 페이지 네비게이션을 출력한다. 필요에 따라 이 클래스를 상속하고 doStartTag를 적절하게 구현하여 사용하도록 한다.
 * 
 * @project SIV
 * @author Kim K. Seok
 * @date	2007. 6. 20.
 * <br>
 */
public class PageNavigationTag extends TagSupport {
	/** 현재 페이지 번호 */
	protected int	pageNo;
	
	/** 시작 페이지 블럭 */
	protected int	startPage;
	
	/** 끝 페이지 블럭 */
	protected int	lastPage;
	
	/** 마지막 페이지 */
	protected int	maxPage;
	
	/** form name */
	protected String form;
	
	/** pageNo form object name */
	protected String	pageNoObj;

	public int doStartTag() throws JspException {
		JspWriter		out	= this.pageContext.getOut();
		StringBuffer	navi	= new StringBuffer(100);
		
		// 이전 페이지 앵커 작성
		if (startPage > 1) {
			int	prev	= startPage - 1;
			navi.append("<a href=\"#\" onclick=\"javascript:return goPage(")
				.append(this.form).append(", ").append(this.pageNoObj)
				.append(", '").append(prev).append("');\">&lt</a>")
                .append("&nbsp;&nbsp;");
		}

		// 페이지 블럭 작성
		for (int i = this.startPage; i <= this.lastPage; i++) {
			if (i == this.pageNo) navi.append(i);	// 현재 페이지에는 앵커를 걸지 않는다
			else {
				navi.append("<a href=\"#\" onclick=\"javascript:return goPage(")
					.append(this.form).append(",").append(this.pageNoObj).append(",'")
					.append(i).append("');\">").append(i).append("</a>");
			}

            navi.append("&nbsp;&nbsp;");
		}
		
		// 다음 페이지 앵커 작성
		if (this.lastPage < this.maxPage) {
			int	next	= this.lastPage + 1;
			navi.append("<a href=\"#\" onclick=\"javascript:return goPage(")
			.append(this.form).append(",").append(this.pageNoObj).append(",'")
			.append(next).append("');\">&gt</a>");
		}
	
        try {
            out.write(navi.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        
		return TagSupport.SKIP_BODY;
	}
	
	public String getForm() {
		return form;
	}

	public void setForm(String form) {
		this.form = form;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public String getPageNoObj() {
		return pageNoObj;
	}

	public void setPageNoObj(String pageNoObj) {
		this.pageNoObj = pageNoObj;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
}


