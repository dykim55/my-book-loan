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
    
    $(function() {
        $("button").button();
    });
    
    </script>
    
    <style>
	    #adminLogin {
	        width:1024px; 
	        margin:auto;
	    }
	    
        #adminLogin table {width:512px; border-collapse:collapse; padding:0; table-layout:fixed; border:0px solid #dedede;}
        #adminLogin table tbody th {background:url(../css/pepper-grinder/images/ui-bg_fine-grain_15_ffffff_60x60.png) repeat-x; height:22px; border-top:1px solid #dedede; border-left:1px solid #dedede; border-right:1px solid #dedede; border-bottom:1px solid #dedede; color:#0a0a0a; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; font-weight:bold; text-align:center; }
        #adminLogin table tbody td {background:none; border-bottom:0px solid #dedede; color:#8e8e8e; text-align:left;}
	    
    </style>
    
</head>

<body>

    <div id="adminLogin">
    <form name="frm" method="post" action="${pageContext.request.contextPath}/login/login.do">
        <table style="position:relative; left:50%; margin-left:-256px;">
            <colgroup>
                <col style="width:20%;" />
                <col style="width:20%;" />
                <col style="width:20%;" />
                <col style="width:20%;" />
                <col style="width:20%;" />
            </colgroup>
            <tbody>        
	            <tr>
	                <th><label>아이디: </label></td>
	                <td><input style="width:90%" name="login_id" value="dykim"></td>
	                <th><label>비밀번호: </label></td>
	                <td><input type="password" style="width:90%" name="login_password" value="1234"></td>
	                <td><button>로그인</button></td>
	            </tr>
            </tbody>
        </table>
    </form>
    </div>

</body>
</html>