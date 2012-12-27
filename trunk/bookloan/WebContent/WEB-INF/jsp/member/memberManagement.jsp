<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "com.company.util.CodeSelect;" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>회원관리</title>
    
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
        //<![CDATA[
        $(document).ready(function () {

        	grid = $("#list");

        	grid.jqGrid({
            	url:  "${pageContext.request.contextPath}/member/searchMemberInfo.ajax",
            	datatype: "json",
            	mtype: 'POST',
                colNames:['회원번호','회원명','생년월일','양/음','전화번호','휴대폰번호','주소','가입일','상태','비고'],
                colModel:[
                    {name:'m_no',		index:'m_no',		width:50, 	align:'center'}, 
                    {name:'m_name',		index:'m_name',		width:60, 	align:'center'},
                    {name:'m_birth_dt',	index:'m_birth_dt',	width:60, 	align:'center', formatter:dateFormatter},
                    {name:'m_calr_tp',	index:'m_calr_tp',	width:30, 	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '1:양력;2:음력'}},
                    {name:'m_tel_no',	index:'m_tel_no',	width:70, 	align:'center', formatter:phoneFormatter},
                    {name:'m_cell_no',	index:'m_cell_no',	width:70,	align:'center', formatter:phoneFormatter},
                    {name:'m_addr',		index:'m_addr',		width:140,	align:'left'},
                    {name:'m_entry_dt',	index:'m_entry_dt',	width:80, 	align:'center', formatter:dateFormatter},
                    {name:'m_status',	index:'m_status',	width:40,	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("001") %>'}},
                    {name:'m_cmt',		index:'m_cmt',		width:0,	align:'center', hidden:true}
                ],
                rowNum:10,
                rowList:[10,20,50],
                pager: '#pager',
                jsonReader : {
                	repeatitems:false
                },
                rownumbers:true,
                viewrecords: true,
                forceFit : true,
                caption:'회원목록',
                height: '100%',
                width: '1200'
            });
			
            $( "#dialog-form-registration" ).dialog({
                autoOpen: false,
                width: 600,
                modal: true,
                resizable: false,
                buttons: {
                    "저장": function() {
                    	
                    	if ($("#pm_name").val() == "" || $("#pm_birth_dt").val() == "") {
                    		alert("회원명과 생년월일은 필수 입력값입니다.");
                    		return;
                    	}

                        if ($("#pm_tel_no").val() == "" && $("#pm_cell_no").val() == "") {
                            alert("집전화번호와 휴대폰전화번호 중 최소 하나는 입력해야 합니다.");
                            return;
                        }
                    	
                        $.ajax({
        	                type: "POST",
        	                url:  "${pageContext.request.contextPath}/member/registrationMember.ajax",
        	                data: { 
        	                	m_no: $("#pm_no").val(),
        	                	m_name: $("#pm_name").val(),
        	                	m_birth_dt: $("#pm_birth_dt").val(),
        	                	m_calr_tp: $("#pm_calr_tp").val(),
        	                	m_status: $("#pm_status").val(),
        	                	m_tel_no: $("#pm_tel_no").val(),
        	                	m_cell_no: $("#pm_cell_no").val(),
        	                	m_email: $("#pm_email").val(),
        	                	m_addr: $("#pm_addr").val(),
        	                	m_cmt: $("#pm_cmt").val()
        	                }, 
        	                dataType: "json",
        	                success: function(msg){
        	                	if (msg.err_code=="0000") {
        	                		$("#dialog-form-registration").dialog("close");
                                    alert(msg.err_message);
        	                		grid.trigger("reloadGrid");
        	                	} else {
        	                		alert("[" + msg.err_code + "] " + msg.err_message);
        	                	}
        	                },
        	                error: function(res, status, exeption) {
        	                	alert(exeption);
        	                }
        	            });
                    },
                    "취소": function() {
                        $(this).dialog("close");
                    }
                },
                close: function() {
                }
            });

			//회원등록팝업
            $("#onBtnReg").click(function () {
            	$("#pm_no").val("");
            	$("#pm_name").val("");
            	$("#pm_birth_dt").val("");
            	$("#pm_calr_tp").val("1");
            	$("#pm_status").val("1");
            	$("#pm_tel_no").val("");
            	$("#pm_cell_no").val("");
            	$("#pm_addr").val("");
            	$("#pm_email").val("");
            	$("#pm_cmt").val("");
            	$("#pm_calr_tp").val("1").attr("selected", "selected");
            	$("#pm_status").val("1").attr("selected", "selected");
            	
            	$("#ui-id-1").html("회원정보 등록");
                $("#dialog-form-registration").dialog("open");
            });
            
            //회원수정팝업
            $("#onBtnMdf").click(function () {
            	var selNo = grid.jqGrid('getGridParam','selrow');
            	
            	if (selNo == null) {
            		alert("수정할 회원을 리스트에서 선택하세요.");
            		return;
            	}

            	$("#pm_no").val(grid.getCell(selNo, 1));
            	$("#pm_name").val(grid.getCell(selNo, 2));
            	$("#pm_birth_dt").val(grid.getCell(selNo, 3));
            	$("#pm_calr_tp").val(grid.getCell(selNo, 4));
            	$("#pm_status").val(grid.getCell(selNo, 9));
            	$("#pm_tel_no").val(grid.getCell(selNo, 5));
            	$("#pm_cell_no").val(grid.getCell(selNo, 6));
            	$("#pm_addr").val(grid.getCell(selNo, 7));
            	$("#pm_cmt").val(grid.getCell(selNo, 10));
            	
            	$("#pm_calr_tp").val(grid.getCell(selNo, 4)).attr("selected", "selected");
            	$("#pm_status").val(grid.getCell(selNo, 9)).attr("selected", "selected");
            	
            	$("#ui-id-1").html("회원정보 수정");
            	$("#dialog-form-registration").dialog("open");
            });
            
            //회원조회
            $("#onBtnSch").click(function () {
            	grid.jqGrid('setGridParam',	{ 
            		postData:{
            			m_sdt:$("#m_sdt").val(),
            			m_edt:$("#m_edt").val(),
            			m_no:$("#m_no").val(), 
            			m_name:$("#m_name").val(),
            			m_birth_dt:$("#m_birth_dt").val(),
            			m_phone_tp:$("#m_phone_tp").val(),
            			m_phone_no:$("#m_phone_no").val(),
            			m_status:$("#m_status").val()
            		}
            	}).trigger("reloadGrid");
            });
            
            $("#m_sdt, #m_edt, #m_no,#m_name,#m_birth_dt,#m_phone_no").focus(function(event) {
                $('#'+event.target.id).select();
            });
            
        });
        //]]>
        
        $(function() {
            $("button").button();
            $("#m_sdt, #m_edt, #m_birth_dt, #pm_birth_dt").datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: 'c-80:c',
    			dateFormat: 'yy-mm-dd',
    			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
    		});            
        });
        
        function dateFormatter(cellval, opts, rwdat, _act) {
            var num, year, month, day, hh, mi, ss;
        	num=cellval;
        	if( num != 0 && num.length == 8 ) {
        	    year = num.substring( 0, 4 );
        	    month = num.substring( 4, 6 ); 
        	    day = num.substring(6);
        	    num = year+"-"+month + "-" + day;
        	} else if( num != 0 && num.length == 14 ) {
        	    year = num.substring( 0, 4 );
        	    month = num.substring( 4, 6 ); 
        	    day = num.substring(6, 8);
        	    hh = num.substring(8, 10);
        	    mi = num.substring(10, 12);
        	    ss = num.substring(12, 14);
        	    num = year+"-"+month + "-" + day + " " + hh + ":" + mi + ":" + ss;
        	}
        	else {
        	    num = cellval;
        	} 
            return num;
        }

        function phoneFormatter(cellval, opts, rwdat, _act) {
            var num, n1, n2, n3;
            num=cellval;
            if( num != 0 && num.length == 11 ) {
                n1 = num.substring( 0, 3 );
                n2 = num.substring( 3, 7 ); 
                n3 = num.substring(7);
                num = n1+"-"+n2+"-"+n3;
            } else if( num != 0 && num.length == 10 ) {
                n1 = num.substring( 0, 2 );
                n2 = num.substring( 2, 6 ); 
                n3 = num.substring(6);
                num = n1+"-"+n2+"-"+n3;
            } else {
                num = cellval;
            } 
            return num;
        }
        
    </script>
    
</head>

<body>

<div style="margin-top:10px; height:20px;">
	<div class="info">
		${userId}님 환영합니다. 
		<a href="${pageContext.request.contextPath}/login/logout.do">[로그아웃]</a>
	</div>
</div>

<div id="outer">
    <ul id="menu">
        <li class="sub" id="no1"><a href="#">대출현황</a></li>
        <li class="sub" id="no2"><a href="${pageContext.request.contextPath}/loan/loanView.do">대출관리</a></li>
        <li class="sub" id="no3"><a href="${pageContext.request.contextPath}/book/bookView.do">도서관리</a></li>
        <li class="sub" id="no4"><a class="select" href="#">회원관리</a></li>
        <li class="sub" id="no5"><a href="#">시스템설정</a></li>
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title">◆ 회원관리</div>
        
    <div style="width:1200px;">
    <div style="position: relative; height: 32px;" class="ui-widget">
        <div class="ui-dialog-content ui-widget-content search_box" style="background: none; border: 0;">
	        <table>
	          	<colgroup>
	            	<col style="width:6%;" />
	            	<col style="width:16%;" />
	            	<col style="width:7%;" />
	            	<col style="width:8%;" />
	            	<col style="width:7%;" />
	            	<col style="width:8%;" />
	            	<col style="width:7%;" />
	            	<col style="width:8%;" />
	            	<col style="width:9%;" />
	            	<col style="width:10%;" />
	            	<col style="width:7%;" />
	            	<col style="width:7%;" />
	          	</colgroup>
	          	<tbody>
	            	<tr>
                        <th>가입일</th>
                        <td><input class="text" type="text" style="width:42%" id="m_sdt" name="m_sdt" />&nbsp;~&nbsp;<input class="text" type="text" style="width:42%" id="m_edt" name="m_edt" /></td>
	              		<th>회원번호</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_no" name="m_no" /></td>
	              		<th>회원명</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_name" name="m_name" /></td>
	              		<th>생년월일</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_birth_dt" name="m_birth_dt" /></td>
	              		<th>
                            <select id="m_phone_tp">
                                <option value='1'>휴대폰번호</option>
                                <option value='2'>집전화번호</option>
                            </select>
	              		</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_phone_no" name="m_phone_no" /></td>
	              		<th>회원상태</th>
	              		<td><%=CodeSelect.makeCodeSelect("m_status", "::전체::", "001", "") %></td>
	            	</tr>
				</tbody>
			</table>
        </div>
    </div>
    </div>
    <div class="grid_box clfix">
        <div class="g_areaL clfix">
            <button id="onBtnReg">회원등록</button>
            <button id="onBtnMdf">회원수정</button>
        </div>
        <div class="g_areaR clfix">
            <button id="onBtnSch">회원조회</button>
            <button id="">엑셀저장</button>
        </div>
    </div>
       
	<table id="list">
           <tbody>
               <tr>
                   <td></td>
               </tr>
           </tbody>
       </table>
	<div id="pager"></div>
	
</div>

<div id="dialog-form-registration" title="회원정보 등록">

   	<input type="hidden" id="pm_no" name="pm_no" />
	<div class="ui-dialog-content ui-widget-content popup_box" style="background: none; border: 0;">
		<table style="width:500px">
			<colgroup>
        		<col style="width:20%;" />
        		<col style="width:80%;" />
      		</colgroup>
      		<tbody>
        	<tr>
          		<th><div>회원명</div></th>
          		<td><input class="text" style="background:#faffc8; width:50%" type="text" id="pm_name" name="pm_name" /></td>
        	</tr>
           	<tr>
        		<th><div>생년월일</div></th>
           		<td>
		         	<input class="text" style="background:#faffc8; width:50%" type="text" id="pm_birth_dt" name="pm_birth_dt"  />
           		    <select id="pm_calr_tp">
                   		<option value='1'>양력</option>
                   		<option value='2'>음력</option>
                    </select>
                </td>
            </tr>
           	<tr>
           		<th><div>상   태</div></th>
           		<td><%=CodeSelect.makeCodeSelect("pm_status", "", "001", "")%></td>
           	</tr>
           	<tr>
           		<th><div>전화번호</div></th>
           		<td><input class="text" style="background:#faffc8; width:50%" type="text" id="pm_tel_no" name="pm_tel_no"  /></td>
           	</tr>
           	<tr>
           		<th><div>휴대폰번호</div></th>
           		<td><input class="text" style="background:#faffc8; width:50%" type="text" id="pm_cell_no" name="pm_cell_no"  /></td>
           	</tr>
           	<tr>
           		<th><div>주   소</div></th>
           		<td><input class="text" style="width:100%" type="text" id="pm_addr" name="pm_addr"  /></td>
           	</tr>
           	<tr>
           		<th><div>이메일</div></th>
           		<td><input class="text" style="width:50%" type="text" id="pm_email" name="pm_email"  /></td>
           	</tr>
           	<tr>
           		<th><div>비   고</div></th>
           		<td><input class="text" style="width:100%" type="text" id="pm_cmt" name="pm_cmt"  /></td>
           	</tr>
			</tbody>
		</table>
	</div>

</div>

</body>
</html>