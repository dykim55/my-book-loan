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
			<div class="msg">요청한 URL로의 접근이 거부되었습니다.</div>
			<div class="btnArea">
				<a href="javascript:history.back();" class="btn"><span>뒤로</span></a>
				<a href="${pageContext.request.contextPath}/" class="btn"><span>메인으로</span></a>
			</div>
		</div>
	</div>
	</div>
	<!-- //content -->

</div>
</body>
</html>