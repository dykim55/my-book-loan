<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>로그인</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link href="${pageContext.request.contextPath}/css/hot-sneaks/jquery-ui-1.9.2.custom.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-4.4.1/ui.jqgrid.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-4.4.1/ui.multiselect.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/pro_dropdown_5.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/common.css" type="text/css" rel="stylesheet">    

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.2.custom.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-4.4.1/ui.multiselect.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-4.4.1/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-4.4.1/jquery.jqGrid.src.js"></script>

    <script type="text/javascript">
    
    $(document).ready(function () {
	    $('#login_id, #login_password').keydown(function(e) {
	    	if (e.keyCode==13) {
	    		if ($('#login_id').val().length==0) {
	    			alert('아이디를 입력하세요.');
	    			return;
	    		}
                if ($('#login_password').val().length==0) {
                    alert('비밀번호를 입력하세요.');
                    return;
                }
                
                createCookie("IDsave","true",365);
                createCookie("IDsave_id",frm.login_id.value,365);
                
	    	    frm.submit();
	    	}
	    });
	    
        $("#login_id, #login_password").focus(function(event) {
            $('#'+event.target.id).select();
        });
	    
    });
    
    $(function() {
        $("button").button();
    });
    
    /**
     * 쿠키 저장 
     */
    function createCookie(name,value,day,domain) {
        var cookie = name+"="+value + ";";
        if (day) {
            var date = new Date();
            if(!day)day = 0;
            date.setTime(date.getTime()+(day*24*60*60*1000));
            cookie += " path=/; expires="+date.toGMTString() + " ;";
        }
        document.cookie = cookie;
    }

    /**
     * 쿠키 읽기
     */
    function readCookie(name) {
       var nameEQ = name + "=";
       var ca = document.cookie.split(';');
       for(var i=0;i < ca.length;i++) {
           var c = ca[i];
           while (c.charAt(0)==' ') c = c.substring(1,c.length);
           if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        
        }
        return null;
    }

    function load() {
        <c:if test="${login_failed == 'ID'}">
        alert("아이디와 비밀번호를 다시한번 확인해 주십시오.");
        </c:if> 
        <c:if test="${login_failed == 'PASS'}">
        alert("아이디와 비밀번호를 다시한번 확인해 주십시오.");
        </c:if> 
        
        $('#login_id').focus();
        
        var IDsave = readCookie("IDsave");
        
        if (IDsave == "true") {
            var id = readCookie("IDsave_id");
            if (id != undefined) {
                document.frm.login_id.value = id;
                $('#login_password').focus();
            }
        }
    }
    
    </script>
    
</head>

<body onload="load()">

    <form name="frm" method="post" action="${pageContext.request.contextPath}/login/login.do">
    <div align=center>
    <div style="background:none; width:1200px;">
    <div style="background:none; margin:250px auto 0; width:50%; border: 0;">
    <div class="ui-dialog-content ui-widget-content search_box" style="margin: 15px; background: none; border: 0;">
        <table>
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
	                <td><input style="width:100%" id="login_id" name="login_id"></td>
	                <th><label>비밀번호: </label></td>
	                <td><input type="password" style="width:100%" id="login_password" name="login_password"></td>
	            </tr>
            </tbody>
        </table>
    </div>
    </div>
    </div>
    </div>
    </form>
</body>
</html>