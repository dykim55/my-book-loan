<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>로그인</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link href="${pageContext.request.contextPath}/css/pepper-grinder/jquery-ui-1.9.1.custom.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-4.4.1/ui.jqgrid.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-4.4.1/ui.multiselect.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/pro_dropdown_5.css" type="text/css" rel="stylesheet">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.1.custom.js"></script>
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
                colNames:['고객번호','고객명','생년월일','양/음','전화번호','휴대폰번호','주소','상태','비고'],
                colModel:[
                    {name:'m_no',		index:'m_no',		width:50, 	align:'center'}, 
                    {name:'m_name',		index:'name', 		width:60, 	align:'center'},
                    {name:'m_birth_dt',	index:'m_birth_dt',	width:60, 	align:'center'},
                    {name:'m_calr_tp',	index:'m_calr_tp',	width:30, 	align:'center'},
                    {name:'m_tel_no',	index:'m_tel_no',	width:80, 	align:'left'},
                    {name:'m_cell_no',	index:'m_cell_no',	width:80,	align:'left'},
                    {name:'m_addr',		index:'m_addr',		width:200,	align:'left'},
                    {name:'m_status',	index:'m_status',	width:40,	align:'center'},
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
                caption:'회원목록',
                height: '100%',
                width: '1000'
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
                        $.ajax({
        	                type: "POST",
        	                url:  "${pageContext.request.contextPath}/member/registrationMember.ajax",
        	                data: { 
        	                	m_area: "1",
        	                	m_name: $("#pm_name").val(),
        	                	m_reg_no: $("#pm_reg_no").val(),
        	                	m_birth_dt: $("#pm_birth_dt").val(),
        	                	m_tel_no: $("#pm_tel_no").val(),
        	                	m_cell_no: $("#pm_cell_no").val(),
        	                	m_email: $("#pm_email").val(),
        	                	m_addr: $("#pm_addr").val(),
        	                	m_cmt: $("#pm_cmt").val()
        	                }, 
        	                dataType: "json",
        	                success: function(msg){
        	                	alert(msg.err_code + ':' + msg.err_message);
        	                	if (msg.err_code=="0000") {
        	                		$("#dialog-form-registration").dialog("close");
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

            $("#onBtnReg").click(function () {
            	$("#pm_no").val("");
            	$("#pm_name").val("");
            	$("#pm_birth_dt").val("");
            	$("#pm_calr_tp").val("1");
            	$("#pm_status").val("R");
            	$("#pm_tel_no").val("");
            	$("#pm_cell_no").val("");
            	$("#pm_addr").val("");
            	$("#pm_cmt").val("");
            	$("#pm_calr_tp").val("1").attr("selected", "selected");
            	$("#pm_status").val("R").attr("selected", "selected");
            	
            	$("#ui-id-1").html("회원정보 등록");
                $("#dialog-form-registration").dialog("open");
            });
            
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
            	$("#pm_status").val(grid.getCell(selNo, 8));
            	$("#pm_tel_no").val(grid.getCell(selNo, 5));
            	$("#pm_cell_no").val(grid.getCell(selNo, 6));
            	$("#pm_addr").val(grid.getCell(selNo, 7));
            	$("#pm_cmt").val(grid.getCell(selNo, 9));
            	
            	$("#pm_calr_tp").val(grid.getCell(selNo, 4)).attr("selected", "selected");
            	$("#pm_status").val(grid.getCell(selNo, 8)).attr("selected", "selected");
            	
            	$("#ui-id-1").html("회원정보 수정");
            	$("#dialog-form-registration").dialog("open");
            });
            
            $("#onBtnSch").click(function () {
            	
            	grid.jqGrid('setGridParam',	{ 
            		postData:{
            			m_no:$("#m_no").val(), 
            			m_name:$("#m_name").val(),
            		}
            	}).trigger("reloadGrid");
            	
            });
            
        });
        //]]>
        
        $(function() {
            $("button").button();
            $( "#pm_birth_dt" ).datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: 'c-80:c',
    			dateFormat: 'yy-mm-dd',
    			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
    		});            
        });

    </script>
    
    <style>
        body {
            width:1024px; 
            margin:auto;
            background:#ffffff;
        }
        
		.grid_box {background:#ffffff; width:1000px; height:40px; border:0px solid #8eb4ff;}
		.grid_box .g_areaL {float:left !important; padding:4px 5px 5px 10px; _padding:3px 5px 3px 10px; color:#495b88;}
		.grid_box .g_areaR {float:right !important; padding:4px 5px 5px 0px; color:#495b88; text-align:right;}
        
		.ui-dialog-content table {width:1000px; border-collapse:collapse; padding:0; table-layout:fixed; border:0px solid #dedede;}
		.ui-dialog-content table tbody th {background:#fff url(../css/pepper-grinder/images/ui-bg_fine-grain_15_ffffff_60x60.png) repeat-x;padding:1px 10px; _padding:8px 10px 6px 10px; border-top:1px solid #dedede; border-left:1px solid #dedede; border-right:1px solid #dedede; border-bottom:1px solid #dedede; color:#0a0a0a; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; font-weight:bold; text-align:center; }
		.ui-dialog-content table tbody td {background:none; border-bottom:0px solid #dedede; color:#8e8e8e; text-align:left;}
		.ui-dialog-content table tbody td input {height: 21px; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; vertical-align:middle;}
		.ui-dialog-content table tbody td select {height: 20px; font-size:12px; color:#0a0a0a;font-family:"맑은 고딕", MalgunGothic}

        .title {
            margin-top: .5em;
            width:1000px; 
            font-size:26px;
            text-align:left;
        }

    </style>
    
    
</head>

<body>

<div class="title">Member Management</div>

<div id="outer">
    <ul id="menu">
        <li class="sub" id="no1"><a href="#nogo">대여관리</a></li>
        <li class="sub" id="no2"><a href="#nogo">도서관리</a></li>
        <li class="sub" id="no3"><a class="select" href="#nogo">회원관리</a></li>
    </ul>
</div>
<p></p>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>
    
    <form action="" method="post" id='searchFrm' name='searchFrm'>
    <div style="position: relative; width: 1000px; height: 32px;" class="ui-widget">
        <div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
	        <table>
	          	<colgroup>
	            	<col style="width:8%;" />
	            	<col style="width:12%;" />
	            	<col style="width:8%;" />
	            	<col style="width:12%;" />
	            	<col style="width:8%;" />
	            	<col style="width:12%;" />
	            	<col style="width:8%;" />
	            	<col style="width:12%;" />
	            	<col style="width:8%;" />
	            	<col style="width:12%;" />
	          	</colgroup>
	          	<tbody>
	            	<tr>
	              		<th class="ui-corner-all">고객번호</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_no" name="m_no" /></td>
	              		<th class="ui-corner-all">고객명</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_name" name="m_name" /></td>
	              		<th class="ui-corner-all">생년월일</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_birth_dt" name="m_birth_dt" /></td>
	              		<th class="ui-corner-all">전화번호</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_tel_no" name="m_tel_no" /></td>
	              		<th class="ui-corner-all">회원상태</th>
	              		<td><select id="m_status">
                      			<option>정상</option>
                      			<option>탈퇴</option>
                    		</select>
                    	</td>
	            	</tr>
				</tbody>
			</table>
        </div>
    </div>
    </form>
    
    <div class="grid_box clfix">
        <div class="g_areaR clfix">
            <button id="onBtnSch">회원조회</button>
            <button id="onBtnReg">회원등록</button>
            <button id="onBtnMdf">회원수정</button>
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
    	<input type="text" id="pm_no" name="pm_no" />
		<div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
			<table style="width:500px">
				<colgroup>
	        		<col style="width:20%;" />
	        		<col style="width:80%;" />
	      		</colgroup>
	      		<tbody>
	        	<tr>
	          		<th class="ui-corner-all">회원명</th>
	          		<td><input class="text" style="width:50%" type="text" id="pm_name" name="pm_name" /></td>
	        	</tr>
            	<tr>
              		<th class="ui-corner-all">생년월일</th>
              		<td>
						<input class="text" style="width:50%" type="text" id="pm_birth_dt" name="pm_birth_dt"  />
              			<select id="pm_calr_tp">
                      		<option value='1'>양력</option>
                      		<option value='2'>음력</option>
                    	</select>
                    </td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all" style="height:26px">등록상태</th>
              		<td><select id="pm_status">
                    		<option value='R'>정상</option>
                    		<option value='D'>탈퇴</option>
                    	</select>
                    </td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">전화번호</th>
              		<td><input class="text" style="width:50%" type="text" id="pm_tel_no" name="pm_tel_no"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">휴대폰번호</th>
              		<td><input class="text" style="width:50%" type="text" id="pm_cell_no" name="pm_cell_no"  /></td>
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