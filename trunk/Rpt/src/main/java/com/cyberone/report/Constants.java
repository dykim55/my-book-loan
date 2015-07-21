package com.cyberone.report;



public class Constants {

	public static String getReportTypeName(String type){
		String result;
		switch(Integer.parseInt(type)){
			case 1 : result = "일일보고서";
				break;
			case 2 : result = "주간보고서";
				break;
			case 3 : result = "월간보고서";
				break;
			case 4 : result = "임의기간보고서";
				break;
			default : result = "-";
		}
		return result;
	}
	
}