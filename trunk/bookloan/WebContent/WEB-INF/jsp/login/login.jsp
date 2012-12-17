<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>로그인</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link href="${pageContext.request.contextPath}/css/redmond/jquery-ui-1.9.1.custom.css" rel="stylesheet">
    
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.2.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.1.custom.js"></script>

    <script type="text/javascript">
    </script>
    
    <style>
	    #adminLogin {
	        width:1024px; 
	        margin:auto;
	    }
    </style>
    
</head>

<body>

    <div id="adminLogin">
    <form name="frm" method="post" action="${pageContext.request.contextPath}/login/login.do">
        <table style="position:relative; width:512px; left:50%; margin-left:-256px;">
            <tr>
                <td><label>아이디: </label></td>
                <td><input></td>
                <td><label>비밀번호: </label></td>
                <td><input></td>
            </tr>
        </table>
    </form>
    </div>

</body>
</html>