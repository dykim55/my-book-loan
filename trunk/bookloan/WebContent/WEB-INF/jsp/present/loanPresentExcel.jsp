<%@ page language="java" contentType="application/vnd.ms-excel;text/html;charset=utf-8"%>
<%@ page import= "com.company.framework.utils.DateUtil;" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<%
    response.setHeader("Content-Disposition", "attachment; filename=LoanHistoryExcel_"+DateUtil.getYYYYMMDDHH24MISS()+".xls");
    response.setHeader("Content-Description", "JSP Generated Data");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<style type="text/css">

.txt {mso-number-format:'\@'}

tr
	{mso-height-source:auto;
	mso-ruby-visibility:none;}
col
	{mso-width-source:auto;
	mso-ruby-visibility:none;}
br
	{mso-data-placement:same-cell;}
ruby
	{ruby-align:left;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Malgun Gothic", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:\D45C\C900;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Malgun Gothic", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	text-align:center;
	border:.5pt solid black;
	background:#7F7F7F;
	mso-pattern:black none;}
.xl66
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#7F7F7F;
	mso-pattern:black none;}
.xl67
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}

</style>
</head>

<body>

<table border=0 cellpadding=0 cellspacing=0 width=1336 style='bor=der-collapse: collapse;table-layout:fixed;width:1004pt'>
	<col width=137 style='mso-width-source:userset;mso-width-alt:4384;widt=h:103pt'>
	<col width=64 style='mso-width-source:userset;mso-width-alt:2048;width=:48pt'>
	<col width=74 style='mso-width-source:userset;mso-width-alt:2368;width=:56pt'>
	<col width=203 style='mso-width-source:userset;mso-width-alt:6496;widt=h:152pt'>
	<col width=111 span=2 style='mso-width-source:userset;mso-width-alt:=3552; width:83pt'>
	<col width=74 style='mso-width-source:userset;mso-width-alt:2368;width=:56pt'>
	<col width=59 style='mso-width-source:userset;mso-width-alt:1888;width=:44pt'>
	<col width=101 span=2 style='mso-width-source:userset;mso-width-alt:=3232; width:76pt'>
	<col width=137 style='mso-width-source:userset;mso-width-alt:4384;widt=h:103pt'>
	<col width=90 style='mso-width-source:userset;mso-width-alt:2880;width=:68pt'>
	<col width=74 style='mso-width-source:userset;mso-width-alt:2368;width=:56pt'>

	<tr height=22 style='height:16.5pt'>
		<td height=22 class=xl65 width=137 style='height:16.5pt;width:103=pt'>대출일시</td>
		<td class=xl66 width=64 style='width:48pt'>상태</td>
		<td class=xl66 width=74 style='width:56pt'>도서번호</td>
		<td class=xl66 width=203 style='width:152pt'>제목</td>
		<td class=xl66 width=111 style='width:83pt'>저자</td>
		<td class=xl66 width=111 style='width:83pt'>출판사</td>
		<td class=xl66 width=74 style='width:56pt'>회원번호</td>
		<td class=xl66 width=59 style='width:44pt'>회원명</td>
		<td class=xl66 width=101 style='width:76pt'>집전화번호</td>
		<td class=xl66 width=101 style='width:76pt'>휴대폰번호</td>
		<td class=xl66 width=137 style='width:103pt'>회수완료일</td>
		<td class=xl66 width=90 style='width:68pt'>회수예정일</td>
		<td class=xl66 width=74 style='width:56pt'>회수형태</td>
	</tr>
               
    <c:forEach var="row" items="${rows}" varStatus="status">
	<tr height=22 style='height:16.5pt'>
		<td height=22 class=xl67 style='height:16.5pt'>${row.m_loan_dt}</td>
		<td class=xl67>${row.m_status}</td>
		<td class=xl67>${row.m_book_no}</td>
		<td class=xl67>${row.m_title}</td>
		<td class=xl67>${row.m_author}</td>
		<td class=xl67>${row.m_publisher}</td>
		<td class=xl67>${row.m_no}</td>
		<td class=xl67>${row.m_name}</td>
		<td class=xl67>${row.m_tel_no}</td>
		<td class=xl67>${row.m_cell_no}</td>
		<td class=xl67>${row.m_real_rcv_dt}</td>
		<td class=xl67>${row.m_rcv_plan_dt}</td>
		<td class=xl67>${row.m_rcv_tp}</td>
	</tr>
    </c:forEach>
</table>
</body>
</html>
