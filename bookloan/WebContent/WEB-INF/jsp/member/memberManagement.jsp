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
                colNames:['고객번호','고객명','생년월일','양/음','전화번호','휴대폰번호','주소','가입일','상태','비고'],
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
        	/*
            grid.jqGrid ('navGrid', '#pager',
                         {edit:false, add:false, del:false, refresh:true, view:false},
                         {},{},{},{multipleSearch:true,overlay:false});
            */ 
            
            /*
            //#pager에 button을 추가한다.
            grid.jqGrid ('navButtonAdd', '#pager', {
                caption: "", buttonicon: "ui-icon-calculator", title: "choose columns",
                onClickButton: function() {
                    //Select columns창을 띄운다.
                    grid.jqGrid('columnChooser');
                }
            });
			*/
			
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
    
    <style>
        body {
            margin:auto;
            background:lightgray;
        }
        
		.grid_box {background:lightgray; width:1200px; height:34px; border:0px solid #8eb4ff;}
		.grid_box .g_areaL {float:left !important; padding:4px 5px 5px 5px; _padding:3px 5px 3px 10px; color:#495b88;}
		.grid_box .g_areaR {float:right !important; padding:4px 5px 5px 0px; color:#495b88; text-align:right;}
        
		.ui-dialog-content table {width:1200px; border-collapse:collapse; padding:0; table-layout:fixed; border:0px solid #dedede;}
		.ui-dialog-content table tbody th {background:#fafafa; padding:1px 10px; _padding:8px 10px 6px 10px; border-top:1px solid #dedede; border-left:1px solid #dedede; border-right:1px solid #dedede; border-bottom:1px solid #dedede; color:#0a0a0a; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; font-weight:bold; text-align:center; }
		.ui-dialog-content table tbody td {background:none; padding:0px 10px 0px 5px; border-bottom:0px solid #dedede; color:#8e8e8e; text-align:left;}
		.ui-dialog-content table tbody td input {height: 21px; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; vertical-align:middle;}
		.ui-dialog-content table tbody td select {height: 20px; font-size:12px; color:#0a0a0a;font-family:"맑은 고딕", MalgunGothic}

        .title {
            margin-top: .1em;
            margin-bottom: .5em;
            width:1200px; 
            font-family: "맑은 고딕", MalgunGothic;
            font-size:16px;
            font-weight:bold;
            text-align:left;
        }

		.info { float:right; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; font-weight:bold; }
    </style>
    
    
</head>

<body>

<div style="height:20px;">
	<div class="info">
		${userId}님 환영합니다. 
		<a href="${pageContext.request.contextPath}/login/logout.do">[로그아웃]</a>
	</div>
</div>

<div id="outer">
   	<ul id="menu">
       	<li class="sub" id="no1"><a href="${pageContext.request.contextPath}/loan/loanView.do">대출관리</a></li>
       	<li class="sub" id="no2"><a href="${pageContext.request.contextPath}/book/bookView.do">도서관리</a></li>
       	<li class="sub" id="no3"><a class="select" href="#nogo">회원관리</a></li>
   	</ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title">◆ 회원관리</div>
        
    <form action="" method="post" id='searchFrm' name='searchFrm'>
    <div style="position: relative; height: 32px;" class="ui-widget">
        <div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
	        <table>
	          	<colgroup>
	            	<col style="width:6%;" />
	            	<col style="width:18%;" />
	            	<col style="width:6%;" />
	            	<col style="width:8%;" />
	            	<col style="width:6%;" />
	            	<col style="width:8%;" />
	            	<col style="width:6%;" />
	            	<col style="width:8%;" />
	            	<col style="width:10%;" />
	            	<col style="width:10%;" />
	            	<col style="width:6%;" />
	            	<col style="width:8%;" />
	          	</colgroup>
	          	<tbody>
	            	<tr>
                        <th class="ui-corner-all">가입일</th>
                        <td><input class="text" type="text" style="width:42%" id="m_sdt" name="m_sdt" />&nbsp;~&nbsp;<input class="text" type="text" style="width:42%" id="m_edt" name="m_edt" /></td>
	              		<th class="ui-corner-all">고객번호</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_no" name="m_no" /></td>
	              		<th class="ui-corner-all">고객명</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_name" name="m_name" /></td>
	              		<th class="ui-corner-all">생년월일</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_birth_dt" name="m_birth_dt" /></td>
	              		<th class="ui-corner-all">
                            <select id="m_phone_tp">
                                <option value='1'>휴대폰번호</option>
                                <option value='2'>집전화번호</option>
                            </select>
	              		</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_phone_no" name="m_phone_no" /></td>
	              		<th class="ui-corner-all">회원상태</th>
	              		<td><%=CodeSelect.makeCodeSelect("m_status", "::전체::", "001", "") %></td>
	            	</tr>
				</tbody>
			</table>
        </div>
    </div>
    </form>
    <p></p>
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

<div id="dialog-form-registration" title="회원등록">

    <form>
    	<input type="hidden" id="pm_no" name="pm_no" />
		<div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
			<table style="width:500px">
				<colgroup>
	        		<col style="width:20%;" />
	        		<col style="width:80%;" />
	      		</colgroup>
	      		<tbody>
	        	<tr>
	          		<th class="ui-corner-all">회원명</th>
	          		<td><input class="text" style="background:#faffc8; width:50%" type="text" id="pm_name" name="pm_name" /></td>
	        	</tr>
            	<tr>
              		<th class="ui-corner-all">생년월일</th>
              		<td>
						<input class="text" style="background:#faffc8; width:50%" type="text" id="pm_birth_dt" name="pm_birth_dt"  />
              			<select id="pm_calr_tp">
                      		<option value='1'>양력</option>
                      		<option value='2'>음력</option>
                    	</select>
                    </td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all" style="height:26px">등록상태</th>
              		<td><%=CodeSelect.makeCodeSelect("pm_status", "", "001", "")%></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">전화번호</th>
              		<td><input class="text" style="background:#faffc8; width:50%" type="text" id="pm_tel_no" name="pm_tel_no"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">휴대폰번호</th>
              		<td><input class="text" style="background:#faffc8; width:50%" type="text" id="pm_cell_no" name="pm_cell_no"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">주소</th>
              		<td><input class="text" style="width:100%" type="text" id="pm_addr" name="pm_addr"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">이메일</th>
              		<td><input class="text" style="width:50%" type="text" id="pm_email" name="pm_email"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">비고</th>
              		<td><input class="text" style="width:100%" type="text" id="pm_cmt" name="pm_cmt"  /></td>
            	</tr>
				</tbody>
			</table>
		</div>
    </form>

</div>

</body>
</html>