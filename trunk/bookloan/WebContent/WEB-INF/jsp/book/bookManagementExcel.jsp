<%@ page language="java" contentType="application/vnd.ms-excel;text/html;charset=utf-8"%>
<%@ page import= "com.company.framework.utils.DateUtil;" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<%
    response.setHeader("Content-Disposition", "attachment; filename=BookInfoExcel_"+DateUtil.getYYYYMMDDHH24MISS()+".xls");
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

<table border=0 cellpadding=0 cellspacing=0 width=1474 style='bor=der-collapse: collapse;table-layout:fixed;width:1106pt;bor=der-collapse: collapse; bor=der-collapse: collapse'>
	<col width=80 style='mso-width-source:userset;mso-width-alt:2560;width=:60pt; width=:60pt;widt=h:103pt'>
	<col width=396 style='mso-width-source:userset;mso-width-alt:12672;wid=th:297pt; width=:68pt;width=:48pt'>
	<col width=177 style='mso-width-source:userset;mso-width-alt:5664;widt=h:133pt; width=:49pt;width=:56pt'>
	<col width=219 style='mso-width-source:userset;mso-width-alt:7008;widt=h:164pt; width=:71pt;widt=h:152pt'>
	<col width=96 span=2 style='mso-width-source:userset;mso-width-alt:3=072; width:72pt;mso-width-alt:=3680;mso-width-alt:=3552'>
	<col width=68 style='mso-width-source:userset;mso-width-alt:2176;width=:51pt; wid=th:273pt;width=:56pt'>
	<col width=103 style='mso-width-source:userset;mso-width-alt:3296;widt=h:77pt; widt=h:103pt;width=:44pt'>
	<col width=157 style='mso-width-source:userset;mso-width-alt:5024;widt=h:118pt; width=:57pt;mso-width-alt:=3232'>
	<col width=82 style='mso-width-source:userset;mso-width-alt:2624;width=:62pt; widt=h:122pt;widt=h:103pt'>
	<col width=137 style='mso-width-source:userset;mso-width-alt:4384;widt=h:103pt; widt=h:103pt;width=:68pt'>
	<col width=90 style='mso-width-source:userset;mso-width-alt:2880;width=:68pt; width=:68pt'>

	<tr height=22 style='height:16.5pt'>
		<td height=22 class=xl65 width=80 style='height:16.5pt;width:60pt=;width:60pt=;  width:103=pt'>도서번호</td>
		<td class=xl66 width=396 style='width:297pt'>도서제목</td>
		<td class=xl66 width=177 style='width:133pt'>저자</td>
		<td class=xl66 width=219 style='width:164pt'>출판사</td>
		<td class=xl66 width=96 style='width:72pt'>장르</td>
		<td class=xl66 width=96 style='width:72pt'>구입일자</td>
		<td class=xl66 width=68 style='width:51pt'>상태</td>
		<td class=xl66 width=103 style='width:77pt'>대출여부</td>
		<td class=xl66 width=157 style='width:118pt'>비고</td>
		<td class=xl66 width=82 style='width:62pt'>대출회원</td>
	</tr>

    <c:forEach var="row" items="${rows}" varStatus="status">
	<tr height=22 style='height:16.5pt'>
		<td height=22 class=xl67 style='height:16.5pt'>${row.m_book_no}</td>
		<td class=xl67>${row.m_title}</td>
		<td class=xl67>${row.m_author}</td>
		<td class=xl67>${row.m_publisher}</td>
		<td class=xl67>${row.m_genre}</td>
		<td class=xl67>${row.m_buy_dt}</td>
		<td class=xl67>${row.m_status}</td>
		<td class=xl67>${row.m_loan_st}</td>
		<td class=xl67>${row.m_cmt}</td>
		<td class=xl67>${row.m_no}</td>
	</tr>
    </c:forEach>
</table>
</body>
</html>
