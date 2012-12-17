package com.company.util;

import java.util.List;

import com.company.card.dto.CodeDTO;
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
	
	public static String makeCodeSelect(String name, String first, String cod1, String cod2, String cdfg) throws Exception {
		
		CodeDTO dto = new CodeDTO();
		dto.setCod_cod1(cod1);
		dto.setCod_cdfg(cdfg);
		
		List<CodeDTO> list = connection.queryForList("common.selectCodeList", dto);
		
		StringBuffer buf = new StringBuffer(100);
		
		buf.append("<select name=\"").append(name).append("\" id=\"").append(name).append("\" >");
		
		if (first != null && !"".equals(first)) {
			buf.append("	<option value=\""+""+"\">").append(first).append("</option>");		
		}

		for (CodeDTO result : list){
			buf.append("	<option value=\"").append(result.getCod_cod2()).append("\" ").append(cod2 != null && result.getCod_cod2().equals(cod2) ? "selected=\"selected\"" : "").append('>').append(result.getCod_name()).append("</option>");
		}
		buf.append("</select>");
		System.out.println("buf.toString()=[" + buf.toString() + "]");
		return buf.toString();
	}
	
}
