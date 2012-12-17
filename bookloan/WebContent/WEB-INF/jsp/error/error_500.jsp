<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>오류</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
</head>
<body>

<div id="adminWrap">

	<!-- content -->
	<div id="adminContainer">
		<div id="adminContent">
	
			<div class="error">
				<div class="msg">
				    <!--
                    <%=exception.getClass().getName()%><br/>
                    <%=exception.getMessage()%><br/>
                    -->
					오류가 발생했습니다.<br />
					문제가 계속되면 관리자에게 문의하시기 바랍니다.
				</div>
				<div class="btnArea">
					<a href="javascript:history.back();" class="btn"><span>뒤로</span></a>
					<a href="${pageContext.request.contextPath}/" class="btn"><span>메인으로</span></a>
				</div>
			</div>
	
		</div>
	</div>
	<!-- //content -->

	<!-- footer -->
	<div id="adminFooter">
	</div>
	<!-- //footer -->
</div>
</body>
</html>