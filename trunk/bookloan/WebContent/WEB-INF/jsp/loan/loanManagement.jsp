<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>도서관리</title>
    
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
            	url:  "${pageContext.request.contextPath}/book/searchBookInfo.ajax",
            	datatype: "json",
            	mtype: 'POST',
                colNames:['도서번호','도서제목','저자','출판사','장르','구입일자','도서상태','대출여부','비고'],
                colModel:[
                    {name:'m_book_no',	index:'m_book_no',	width:50, 	align:'center'}, 
                    {name:'m_title',	index:'m_title', 	width:200, 	align:'center'},
                    {name:'m_author',	index:'m_author',	width:80, 	align:'center'},
                    {name:'m_publisher',index:'m_publisher',width:100, 	align:'center'},
                    {name:'m_genre',	index:'m_genre',	width:80, 	align:'center'},
                    {name:'m_buy_dt',	index:'m_buy_dt',	width:80,	align:'center', formatter:dateFormatter},
                    {name:'m_status',	index:'m_status',	width:40,	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '1:정상;2:분실', defaultValue:'정상'}},
                    {name:'m_loan_st',	index:'m_loan_st',	width:40,	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '1:회수;2:대출', defaultValue:'회수'}},
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
                caption:'도서목록',
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
                    	
                    	if ($("#pm_title").val() == "") {
                    		alert("도서제목은 필수 입력값입니다.");
                    		return;
                    	}

                        $.ajax({
        	                type: "POST",
        	                url:  "${pageContext.request.contextPath}/book/registrationBook.ajax",
        	                data: { 
        	                	m_book_no: $("#pm_book_no").val(),
        	                	m_title: $("#pm_title").val(),
        	                	m_author: $("#pm_author").val(),
        	                	m_publisher: $("#pm_publisher").val(),
        	                	m_genre: $("#pm_genre").val(),
        	                	m_buy_dt: $("#pm_buy_dt").val(),
        	                	m_status: $("#pm_status").val(),
        	                	m_buy_cnt: $("#pm_buy_cnt").val(),
        	                	m_cmt: $("#pm_cmt").val()
        	                }, 
        	                dataType: "json",
        	                success: function(msg){
        	                	if (msg.err_code=="0000") {
        	                		if (msg.save_type == "U") {
        	                			$("#dialog-form-registration").dialog("close");
        	                	    }
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
            	$("#pm_book_no").val("");
            	$("#pm_title").val("");
            	$("#pm_author").val("");
            	$("#pm_publisher").val("");
            	$("#pm_genre").val("1");
            	$("#pm_buy_dt").val("");
            	$("#pm_status").val("1");
            	$("#pm_buy_cnt").val("1");
            	$("#pm_cmt").val("");

            	$("#pm_genre").val("1").attr("selected", "selected");
            	$("#pm_status").val("1").attr("selected", "selected");
            	$("#pm_buy_cnt").attr("disabled",false);
            	
            	$("#ui-id-1").html("도서정보 등록");
                $("#dialog-form-registration").dialog("open");
            });
            
            //회원수정팝업
            $("#onBtnMdf").click(function () {
            	var selNo = grid.jqGrid('getGridParam','selrow');
            	
            	if (selNo == null) {
            		alert("수정할 도서를 리스트에서 선택하세요.");
            		return;
            	}

            	$("#pm_book_no").val(grid.getCell(selNo, 1));
            	$("#pm_title").val(grid.getCell(selNo, 2));
            	$("#pm_author").val(grid.getCell(selNo, 3));
            	$("#pm_publisher").val(grid.getCell(selNo, 4));
            	$("#pm_genre").val(grid.getCell(selNo, 5));
            	$("#pm_buy_dt").val(grid.getCell(selNo, 6));
            	$("#pm_status").val(grid.getCell(selNo, 7));
            	$("#pm_buy_cnt").val("1");
            	$("#pm_cmt").val(grid.getCell(selNo, 9));

            	$("#pm_genre").val(grid.getCell(selNo, 5)).attr("selected", "selected");
            	$("#pm_status").val(grid.getCell(selNo, 7)).attr("selected", "selected");
            	$("#pm_buy_cnt").attr("disabled",true);
            	
            	$("#ui-id-1").html("도서정보 수정");
            	$("#dialog-form-registration").dialog("open");
            });
            
            //
            $("#onBtnSch").click(function () {
            	grid.jqGrid('setGridParam',	{ 
            		postData:{
            			m_sdt:$("#m_sdt").val(),
            			m_edt:$("#m_edt").val(),
            			m_book_no:$("#m_book_no").val(), 
            			m_title:$("#m_title").val(),
            			m_author:$("#m_author").val(),
            			m_publisher:$("#m_publisher").val(),
            			m_genre:$("#m_genre").val(),
            			m_status:$("#m_status").val()
            		}
            	}).trigger("reloadGrid");
            });
            
            $("#m_sdt, #m_edt, #m_book_no,#m_title,#m_author,#m_publisher").focus(function(event) {
                $('#'+event.target.id).select();
            });
            
        });
        //]]>
        
        $(function() {
            $("button").button();
            $("#m_sdt, #m_edt, #pm_buy_dt").datepicker({
    			changeMonth: true,
    			changeYear: true,
    			yearRange: 'c-5:c',
    			dateFormat: 'yy-mm-dd',
    			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
    		});            
        });
        
        function dateFormatter(cellval, opts, rwdat, _act) {
            var num, year, month, day;
        	num=cellval;
        	if( num != 0 && num.length == 8 ) {
        	    year = num.substring( 0, 4 );
        	    month = num.substring( 4, 6 ); 
        	    day = num.substring(6);
        	    num = year+"-"+month + "-" + day;
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
        <li class="sub" id="no1"><a href="#nogo">대여관리</a></li>
        <li class="sub" id="no2"><a class="select" href="#nogo">도서관리</a></li>
        <li class="sub" id="no3"><a href="${pageContext.request.contextPath}/member/memberView.do">회원관리</a></li>
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title">◆도서관리</div>
    
    <form>
    <div style="position: relative; height: 32px;" class="ui-widget">
        <div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
	        <table>
	          	<colgroup>
	            	<col style="width:6%;" />
	            	<col style="width:16%;" />
	            	<col style="width:6%;" />
	            	<col style="width:6%;" />
	            	<col style="width:6%;" />
	            	<col style="width:16%;" />
	            	<col style="width:6%;" />
	            	<col style="width:8%;" />
	            	<col style="width:6%;" />
	            	<col style="width:10%;" />
	            	<col style="width:6%;" />
	            	<col style="width:8%;" />
	          	</colgroup>
	          	<tbody>
	            	<tr>
                        <th class="ui-corner-all">구입일</th>
                        <td><input class="text" type="text" style="width:42%" id="m_sdt" name="m_sdt" />&nbsp;~&nbsp;<input class="text" type="text" style="width:42%" id="m_edt" name="m_edt" /></td>
	              		<th class="ui-corner-all">도서번호</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_book_no" name="m_book_no" /></td>
	              		<th class="ui-corner-all">도서제목</th>
	              		<td><input class="text" type="text" style="width:95%" id="m_title" name="m_title" /></td>
	              		<th class="ui-corner-all">도서저자</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_author" name="m_author" /></td>
	              		<th class="ui-corner-all">출판사</th>
	              		<td><input class="text" type="text" style="width:90%" id="m_publisher" name="m_publisher" /></td>
	              		<th class="ui-corner-all">도서장르</th>
	              		<td><select id="m_genre">
	              		        <option value=''>::전체::</option>
                      			<option value='1'>간행물</option>
                      			<option value='2'>월간지</option>
                    		</select>
                    	</td>
	            	</tr>
				</tbody>
			</table>
        </div>
    </div>
    </form>
    <p></p>
    <div class="grid_box clfix">
        <div class="g_areaL clfix">
            <button id="onBtnReg">도서등록</button>
            <button id="onBtnMdf">도서수정</button>
        </div>
        <div class="g_areaR clfix">
            <button id="onBtnSch">도서조회</button>
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
    	<input type="hidden" id="pm_book_no" name="pm_book_no" />
		<div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
			<table style="width:500px">
				<colgroup>
	        		<col style="width:20%;" />
	        		<col style="width:80%;" />
	      		</colgroup>
	      		<tbody>
	        	<tr>
	          		<th class="ui-corner-all">도서제목</th>
	          		<td><input class="text" style="background:#faffc8; width:100%" type="text" id="pm_title" name="pm_title" /></td>
	        	</tr>
            	<tr>
              		<th class="ui-corner-all">도서저자</th>
              		<td>
						<input class="text" style="width:50%" type="text" id="pm_author" name="pm_author"  />
                    </td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">출판사</th>
              		<td><input class="text" style="width:50%" type="text" id="pm_publisher" name="pm_publisher"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all" style="height:26px">도서장르</th>
              		<td><select id="pm_genre">
                    		<option value='1'>간행물</option>
                    		<option value='2'>월간지</option>
                    	</select>
                    </td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">구입일자</th>
              		<td><input class="text" style="width:50%" type="text" id="pm_buy_dt" name="pm_buy_dt"  /></td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all" style="height:26px">도서상태</th>
              		<td><select id="pm_status">
                    		<option value='1'>정상</option>
                    		<option value='2'>분실</option>
                    	</select>
                    </td>
            	</tr>
            	<tr>
              		<th class="ui-corner-all">구입수량</th>
              		<td><input class="text" style="width:10%" type="text" id="pm_buy_cnt" name="pm_buy_cnt"  /></td>
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