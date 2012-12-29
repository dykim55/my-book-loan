<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "com.company.util.CodeSelect;" %>
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
            	url:  "${pageContext.request.contextPath}/book/searchBookInfo.ajax",
            	datatype: "json",
            	mtype: 'POST',
                colNames:['도서번호','도서제목','저자','출판사','장르','구입일자','도서상태','대출여부','비고','대출회원'],
                colModel:[
                    {name:'m_book_no',	index:'m_book_no',	width:50, 	align:'center'}, 
                    {name:'m_title',	index:'m_title', 	width:200, 	align:'center'},
                    {name:'m_author',	index:'m_author',	width:80, 	align:'center'},
                    {name:'m_publisher',index:'m_publisher',width:100, 	align:'center'},
                    {name:'m_genre',	index:'m_genre',	width:80, 	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("004") %>'}},
                    {name:'m_buy_dt',	index:'m_buy_dt',	width:80,	align:'center', formatter:dateFormatter},
                    {name:'m_status',	index:'m_status',	width:40,	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("002") %>'}},
                    {name:'m_loan_st',	index:'m_loan_st',	width:40,	align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("003") %>'}},
                    {name:'m_cmt',		index:'m_cmt',		width:0,	align:'center', hidden:true},
                    {name:'m_no',		index:'m_no',		width:0,	align:'center', hidden:true}
                ],
                rowNum:20,
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
                width: '1200',
                loadComplete: function() {
                    var rowIDs = $(this).getDataIDs(); 
                    for (var i=0;i<rowIDs.length;i=i+1) { 
                        rowData=$(this).getRowData(rowIDs[i]);
                        var trElement = jQuery("#"+ rowIDs[i],$(this));
                        if (eval(rowData.m_loan_st) == '2') {
                            trElement.removeClass('ui-widget-content');
                            trElement.addClass('mStatus2');
                        }
                    }
                },
                ondblClickRow: function (rowid, iRow, iCol, e) {
                	if (grid.getCell(rowid, 10).length >= 6) {
                		$("#m_no").val(grid.getCell(rowid, 10));
                        frm.submit();
                	}
                }                
                
            });

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

			//도서등록팝업
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
            
            //도서수정팝업
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
            
            //조회
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
            
            $('#m_sdt, #m_edt, #m_book_no, #m_title, #m_author, #m_publisher').keydown(function(e) {
                if (e.keyCode==13) {
                    grid.jqGrid('setGridParam',    {
                    	page:1
                		,postData:{
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
                    return false;
                }
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
        <li class="sub" id="no3"><a class="select" href="#">도서관리</a></li>
        <li class="sub" id="no4"><a href="${pageContext.request.contextPath}/member/memberView.do">회원관리</a></li>
        <li class="sub" id="no5"><a href="#">시스템설정</a></li>
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title">◆도서관리</div>
    
    <div style="width:1200px;">
    <div style="position: relative; height: 32px;" class="ui-widget">
        <div class="ui-dialog-content ui-widget-content search_box" style="background: none; border: 0;">
	        <table>
	          	<colgroup>
	            	<col style="width:6%;" />
	            	<col style="width:16%;" />
	            	<col style="width:7%;" />
	            	<col style="width:8%;" />
	            	<col style="width:5%;" />
	            	<col style="width:15%;" />
	            	<col style="width:5%;" />
	            	<col style="width:8%;" />
	            	<col style="width:6%;" />
	            	<col style="width:9%;" />
	            	<col style="width:7%;" />
	            	<col style="width:8%;" />
	          	</colgroup>
	          	<tbody>
	            	<tr>
                        <th>구입일</th>
                        <td><input class="text" type="text" style="width:43%" id="m_sdt" name="m_sdt" />~<input class="text" type="text" style="width:43%" id="m_edt" name="m_edt" /></td>
	              		<th>도서번호</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_book_no" name="m_book_no" /></td>
	              		<th>제   목</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_title" name="m_title" /></td>
	              		<th>저   자</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_author" name="m_author" /></td>
	              		<th>출판사</th>
	              		<td><input class="text" type="text" style="width:100%" id="m_publisher" name="m_publisher" /></td>
	              		<th>도서장르</th>
	              		<td><%=CodeSelect.makeCodeSelect("m_genre", "::전체::", "004", "")%></td>
	            	</tr>
				</tbody>
			</table>
        </div>
    </div>
    </div>
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

<div id="dialog-form-registration" title="도서정보 등록">

   	<input type="hidden" id="pm_book_no" name="pm_book_no" />
	<div class="popup_box" style="background: ligthgray; border: 0;">
		<table>
			<colgroup>
        		<col style="width:20%;" />
        		<col style="width:80%;" />
      		</colgroup>
      		<tbody>
        	<tr>
          		<th><div>제   목</div></th>
          		<td><input class="text" style="background:#faffc8; width:100%" type="text" id="pm_title" name="pm_title" /></td>
        	</tr>
           	<tr>
             		<th><div>저   자</div></th>
             		<td>
					<input class="text" style="width:50%" type="text" id="pm_author" name="pm_author"  />
                   </td>
           	</tr>
           	<tr>
             		<th><div>출판사</div></th>
             		<td><input class="text" style="width:50%" type="text" id="pm_publisher" name="pm_publisher"  /></td>
           	</tr>
           	<tr>
             		<th><div>장   르</div></th>
             		<td><%=CodeSelect.makeCodeSelect("pm_genre", "", "004", "")%></td>
           	</tr>
           	<tr>
             		<th><div>구입일자</div></th>
             		<td><input class="text" style="width:50%" type="text" id="pm_buy_dt" name="pm_buy_dt"  /></td>
           	</tr>
           	<tr>
             		<th><div>상   태</div></th>
             		<td><%=CodeSelect.makeCodeSelect("pm_status", "", "002", "")%></td>
           	</tr>
           	<tr>
             		<th><div>구입수량</div></th>
             		<td><input class="text" style="width:10%" type="text" id="pm_buy_cnt" name="pm_buy_cnt"  /></td>
           	</tr>
           	<tr>
             		<th><div>비   고</div></th>
             		<td><input class="text" style="width:100%" type="text" id="pm_cmt" name="pm_cmt"  /></td>
           	</tr>
			</tbody>
		</table>
	</div>
	<form name="frm" method="post" action="${pageContext.request.contextPath}/loan/loanView.do">
		<input type="hidden" id="m_no" name="m_no"  />
	</form>
</div>

</body>
</html>