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
<div id="errorWrap">

	<div class="error">
		<div class="msg">존재하지 않는 URL입니다.</div>
		<div class="btnArea">
			<a href="javascript:history.back();" class="btn"><span>뒤로</span></a>
			<a href="${pageContext.request.contextPath}/" class="btn"><span>메인으로</span></a>
		</div>
	</div>

</div>
</body>
</html>