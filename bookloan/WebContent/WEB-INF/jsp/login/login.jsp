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
    #dialog-link {
        padding: .4em 1em .4em 20px;
        text-decoration: none;
        position: relative;
    }
    #dialog-link span.ui-icon {
        margin: 0 5px 0 0;
        position: absolute;
        left: .2em;
        top: 50%;
        margin-top: -8px;
    }
    #icons {
        margin: 0;
        padding: 0;
    }
    #icons li {
        margin: 2px;
        position: relative;
        padding: 4px 0;
        cursor: pointer;
        float: left;
        list-style: none;
    }
    #icons span.ui-icon {
        float: left;
        margin: 0 4px;
    }
	    
    </style>
    
</head>

<body>

    <button>회원등록</button>
    <button>회원조회</button>

    <p><a href="#" id="dialog-link" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-newwin"></span>Open Dialog</a></p>

    <div id="adminLogin">
    <form name="frm" method="post" action="${pageContext.request.contextPath}/login/login.do">
        <table style="position:relative; width:512px; left:50%; margin-left:-256px;">
            <tr>
                <td><label>아이디: </label></td>
                <td><input name="login_id"></td>
                <td><label>비밀번호: </label></td>
                <td><input name="login_password"></td>
                <td><button>로그인</button></td>
            </tr>
        </table>
    </form>
    </div>

</body>
</html>