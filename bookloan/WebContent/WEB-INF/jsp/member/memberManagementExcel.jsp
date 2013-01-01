<%@ page language="java" contentType="application/vnd.ms-excel;text/html;charset=utf-8"%>
<%@ page import= "com.company.framework.utils.DateUtil;" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<%
    response.setHeader("Content-Disposition", "attachment; filename=MemberInfoExcel_"+DateUtil.getYYYYMMDDHH24MISS()+".xls");
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

<table border=0 cellpadding=0 cellspacing=0 width=1300 style='bor=der-collapse: collapse;table-layout:fixed;width:975pt;bor=der-collapse: collapse'>
	<col width=80 style='mso-width-source:userset;mso-width-alt:2560;width=:60pt; widt=h:103pt'>
	<col width=90 style='mso-width-source:userset;mso-width-alt:2880;width=:68pt; width=:48pt'>
	<col width=65 style='mso-width-source:userset;mso-width-alt:2080;width=:49pt; width=:56pt'>
	<col width=95 style='mso-width-source:userset;mso-width-alt:3040;width=:71pt; widt=h:152pt'>
	<col width=115 span=2 style='mso-width-source:userset;mso-width-alt:=3680; width:86pt;mso-width-alt:=3552'>
	<col width=364 style='mso-width-source:userset;mso-width-alt:11648;wid=th:273pt; width=:56pt'>
	<col width=137 style='mso-width-source:userset;mso-width-alt:4384;widt=h:103pt; width=:44pt'>
	<col width=76 style='mso-width-source:userset;mso-width-alt:2432;width=:57pt; mso-width-alt:=3232'>
	<col width=163 style='mso-width-source:userset;mso-width-alt:5216;widt=h:122pt; widt=h:103pt'>
	<col width=137 style='mso-width-source:userset;mso-width-alt:4384;widt=h:103pt; width=:68pt'>
	<col width=90 style='mso-width-source:userset;mso-width-alt:2880;width=:68pt'>

	<tr height=22 style='height:16.5pt'>
		<td height=22 class=xl65 width=80 style='height:16.5pt;width:60pt=;width:103=pt'>회원번호</td>
		<td class=xl66 width=90 style='width:68pt'>회원명</td>
		<td class=xl66 width=65 style='width:49pt'>성별</td>
		<td class=xl66 width=95 style='width:71pt'>생년월일</td>
		<td class=xl66 width=115 style='width:86pt'>전화번호</td>
		<td class=xl66 width=115 style='width:86pt'>휴대폰번호</td>
		<td class=xl66 width=364 style='width:273pt'>주소</td>
		<td class=xl66 width=137 style='width:103pt'>가입일시</td>
		<td class=xl66 width=76 style='width:57pt'>상태</td>
		<td class=xl66 width=163 style='width:122pt'>비고</td>
	</tr>

    <c:forEach var="row" items="${rows}" varStatus="status">
	<tr height=22 style='height:16.5pt'>
		<td height=22 class=xl67 style='height:16.5pt'>${row.m_no}</td>
		<td class=xl67>${row.m_name}</td>
		<td class=xl67>${row.m_gender}</td>
		<td class=xl67>${row.m_birth_dt}</td>
		<td class=xl67>${row.m_tel_no}</td>
		<td class=xl67>${row.m_cell_no}</td>
		<td class=xl67>${row.m_addr}</td>
		<td class=xl67>${row.m_entry_dt}</td>
		<td class=xl67>${row.m_status}</td>
		<td class=xl67>${row.m_cmt}</td>
	</tr>
    </c:forEach>
</table>
</body>
</html>
