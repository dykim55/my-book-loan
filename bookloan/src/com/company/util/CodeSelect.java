package com.company.util;

import java.util.List;

import com.company.book.dto.CodeDTO;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @author
 * 
 */
public class CodeSelect {
	
	private static SqlMapClient connection;

	public void setConnection(SqlMapClient connection) {
		this.connection = connection;
	}
	
	public static String makeCodeSelect(String name, String first, String cod1, String cod2) throws Exception {
		
		CodeDTO dto = new CodeDTO();
		dto.setCode_group_cd(cod1);
		dto.setCode_cd(cod2);
		
		List<CodeDTO> list = connection.queryForList("common.selectCodeList", dto);
		
		StringBuffer buf = new StringBuffer(100);
		
		buf.append("<select name=\"").append(name).append("\" id=\"").append(name).append("\" >");
		
		if (first != null && !"".equals(first)) {
			buf.append("	<option value=\""+""+"\">").append(first).append("</option>");		
		}

		for (CodeDTO result : list){
			buf.append("	<option value=\"").append(result.getCode_cd()).append("\" ").append(cod2 != null && result.getCode_cd().equals(cod2) ? "selected=\"selected\"" : "").append('>').append(result.getCode_name()).append("</option>");
		}
		buf.append("</select>");
		System.out.println("buf.toString()=[" + buf.toString() + "]");
		return buf.toString();
	}

	public static String makeEditOption(String cod1) throws Exception {
		
		CodeDTO dto = new CodeDTO();
		dto.setCode_group_cd(cod1);
		
		List<CodeDTO> list = connection.queryForList("common.selectCodeList", dto);
		
		StringBuffer buf = new StringBuffer(100);
		
		int nIdx = 1;
		for (CodeDTO result : list){
			buf.append(result.getCode_cd()).append(":").append(result.getCode_name());
			if (nIdx++ < list.size()) {
				buf.append(";");
			}
		}
		System.out.println("buf.toString()=[" + buf.toString() + "]");
		return buf.toString();
	}
	
}
