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

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.2.custom.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-4.4.1/ui.multiselect.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-4.4.1/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-4.4.1/jquery.jqGrid.src.js"></script>

    <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function () {

        	gridM = $("#listMember");
        	gridB = $("#listBook");
        	gridH = $("#listHistory");
        	
        	gridM.jqGrid({
            	datatype: "json",
            	mtype: 'POST',
            	colNames:['고객번호','고객명','생년월일','양/음','전화번호','휴대폰번호',''],
                colModel:[
                    {name:'m_no',       index:'m_no',       width:50,   align:'center'}, 
                    {name:'m_name',     index:'m_name',     width:60,   align:'center'},
                    {name:'m_birth_dt', index:'m_birth_dt', width:60,   align:'center', formatter:dateFormatter},
                    {name:'m_calr_tp',  index:'m_calr_tp',  width:30,   align:'center', formatter:'select',  edittype:'select', editoptions: {value: '1:양력;2:음력', defaultValue:'양력'}},
                    {name:'m_tel_no',   index:'m_tel_no',   width:70,   align:'center', formatter:phoneFormatter},
                    {name:'m_cell_no',  index:'m_cell_no',  width:70,   align:'center', formatter:phoneFormatter},
                    {name:'m_loan_cnt', index:'m_loan_cnt', width:0,    align:'center', hidden:true}
                ],
                jsonReader : {
                	repeatitems:false
                },
                rownumbers:true,
                forceFit : true,
                caption:'회원정보',
                height: '100%',
                width: '580',
                loadComplete: function () {
                    var count = gridM.jqGrid('getGridParam','reccount');
                    if (count == 1) {
                        gridH.jqGrid('setGridParam',    {
                        	url:"${pageContext.request.contextPath}/loan/searchLoanHistory.ajax"
                            ,postData:{
                                m_no:gridM.getCell(1, 1)
                            }
                        }).trigger("reloadGrid");
                    } else {
                    	gridH.jqGrid('clearGridData');
                    }
                },
                ondblClickRow: function (rowid, iRow, iCol, e) {
                    gridM.jqGrid('setGridParam',    { 
                        postData:{
                            m_no:gridM.getCell(iRow, 1)
                        }
                    }).trigger("reloadGrid");
                }                
            });
			
            gridB.jqGrid({
                datatype: "json",
                mtype: 'POST',
                colNames:['상태','도서번호','제  목','저  자','회수예정일',''],
                colModel:[
                    {name:'m_loan_st',   index:'m_loan_st',   width:40,   align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("003") %>'}},      
                    {name:'m_book_no',   index:'m_book_no',   width:60,   align:'center'}, 
                    {name:'m_title',     index:'m_title',     width:120,   align:'left'},
                    {name:'m_author',    index:'m_author',    width:50,   align:'center'},
                    {name:'m_rcv_plan_dt', index:'m_rcv_plan_dt', width:80,   align:'center', formatter:dateFormatter},
                    {name:'action',                           width:30, align:'center', sortable: false,
                        formatter:function(cellval, opts, rwdat, _act) {
                        	if (rwdat.m_loan_st == "1") {
                        	    return "<span style=\"cursor:pointer;\"><u>대출</u></span>"
                        	} else {
                        		return "";
                        	}
                        }}
                ],
                jsonReader : {
                    repeatitems:false
                },
                rownumbers:true,
                forceFit : true,
                caption:'도서정보',
                height: '100%',
                width: '580',
                beforeSelectRow: function (rowid, e) {
                    var iCol = $.jgrid.getCellIndex(e.target);
                    if (iCol == 6) {
                    	if (gridB.getCell(rowid, iCol) != "") {
                    		var count = gridM.jqGrid('getGridParam','reccount');
                    		if (count > 1) {
                    			alert("대출대상 회원이 너무 많습니다.");
                    			return true;
                    		}
                    		
                    		count = gridM.getCell(1, 7);
                    		if (count >= 3) {
                                alert("대출건수가 이미 3건이상입니다.");
                                return true;
                    		}
                    		var meberNo = gridM.getCell(1, 1);
                    		
                    		if (confirm("대출 하시겠습니까?")) {
                    			
	                            $.ajax({
	                                type: "POST",
	                                url: "${pageContext.request.contextPath}/loan/registrationLoan.ajax",
	                                data: {
	                                	m_no:gridM.getCell(1, 1),
	                                    m_book_no:gridB.getCell(rowid, 2)
	                                }, 
	                                dataType: "json",
	                                success: function(msg){
	                                    if (msg.err_code=="0000") {
	                                        if (msg.save_type == "U") {
	                                            $("#dialog-form-registration").dialog("close");
	                                        }
	                                        alert(msg.err_message);
	                                        gridM.trigger("reloadGrid");
	                                    } else {
	                                        alert("[" + msg.err_code + "] " + msg.err_message);
	                                    }
	                                },
	                                error: function(res, status, exeption) {
	                                    alert(exeption);
	                                }
	                            });
                    		}
                    	}
                    }
                    return (iCol == 6) ? false : true;
                },
                ondblClickRow: function (rowid, iRow, iCol, e) {
                }                
            });
        	
            gridH.jqGrid({
                datatype: "json",
                mtype: 'POST',
                colNames:['대출일시','상태','도서번호','도서제목','도서저자','출판사',''],
                colModel:[
                    {name:'m_loan_dt',   index:'m_loan_dt',   width:80, align:'center', formatter:dateFormatter}, 
                    {name:'m_status',    index:'m_status',    width:40, align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("003") %>'}},
                    {name:'m_book_no',   index:'m_book_no',   width:40, align:'center'},
                    {name:'m_title',     index:'m_title',     width:100, align:'center'},
                    {name:'m_author',    index:'m_author',    width:40, align:'center'},
                    {name:'m_publisher', index:'m_publisher', width:50, align:'center'},
                    {name:'action',                           width:18, sortable: false, search: false,
                        formatter:function(cellval, opts, rwdat, _act) {
                            return "<span class=\"ui-icon ui-icon-newwin\"></span>"
                        }}

                ],
                jsonReader : {
                    repeatitems:false
                },
                rowNum:10,
                rowList:[10,20,50],
                pager: '#hpager',
                rownumbers:true,
                viewrecords: true,
                forceFit : true,
                caption:'대출이력정보',
                height: '100%',
                width: '580',
                beforeSelectRow: function (rowid, e) {
                    var iCol = $.jgrid.getCellIndex(e.target);
                    if (iCol == 7) {
                        alert("rowid="+rowid+"\niCol: "+iCol);
                    }
                    return (iCol == 7) ? false : true;
                }
                
            });
        	
            $('#m_no, #m_name, #m_phone_no').keydown(function(e) {
                if (e.keyCode==13) {
                    gridM.jqGrid('setGridParam',    {
                    	url:"${pageContext.request.contextPath}/loan/searchMemberInfo.ajax"
                        ,postData:{
                            m_no:$("#m_no").val(), 
                            m_name:$("#m_name").val(),
                            m_phone_no:$("#m_phone_no").val()
                        }
                    }).trigger("reloadGrid");
                }
            });
        	
            $('#m_book_no, #m_title, #m_author').keydown(function(e) {
                if (e.keyCode==13) {
                    gridB.jqGrid('setGridParam',    {
                    	url:"${pageContext.request.contextPath}/loan/searchBookInfo.ajax"
                        ,postData:{
                        	m_book_no:$("#m_book_no").val(), 
                        	m_title:$("#m_title").val(),
                        	m_author:$("#m_author").val()
                        }
                    }).trigger("reloadGrid");
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
                                    gridM.trigger("reloadGrid");
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
            	var selNo = gridM.jqGrid('getGridParam','selrow');
            	
            	if (selNo == null) {
            		alert("수정할 도서를 리스트에서 선택하세요.");
            		return;
            	}

            	$("#pm_book_no").val(gridM.getCell(selNo, 1));
            	$("#pm_title").val(gridM.getCell(selNo, 2));
            	$("#pm_author").val(gridM.getCell(selNo, 3));
            	$("#pm_publisher").val(gridM.getCell(selNo, 4));
            	$("#pm_genre").val(gridM.getCell(selNo, 5));
            	$("#pm_buy_dt").val(gridM.getCell(selNo, 6));
            	$("#pm_status").val(gridM.getCell(selNo, 7));
            	$("#pm_buy_cnt").val("1");
            	$("#pm_cmt").val(gridM.getCell(selNo, 9));

            	$("#pm_genre").val(gridM.getCell(selNo, 5)).attr("selected", "selected");
            	$("#pm_status").val(gridM.getCell(selNo, 7)).attr("selected", "selected");
            	$("#pm_buy_cnt").attr("disabled",true);
            	
            	$("#ui-id-1").html("도서정보 수정");
            	$("#dialog-form-registration").dialog("open");
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
        	} else {
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
        
		.loan_content table {width:50%px; border-collapse:collapse; padding:0; table-layout:fixed; border:0px solid #dedede;}
		.loan_content table tbody th {background:#fafafa; padding:1px 10px; _padding:8px 10px 6px 10px; border-top:1px solid #dedede; border-left:1px solid #dedede; border-right:1px solid #dedede; border-bottom:1px solid #dedede; color:#0a0a0a; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; font-weight:bold; text-align:center; }
		.loan_content table tbody td {background:none; padding:0px 10px 0px 5px; border-bottom:0px solid #dedede; color:#8e8e8e; text-align:left;}
		.loan_content table tbody td input {height: 21px; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; vertical-align:middle;}
		.loan_content table tbody td select {height: 20px; font-size:12px; color:#0a0a0a;font-family:"맑은 고딕", MalgunGothic}

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
        <li class="sub" id="no1"><a class="select" href="#nogo">대여관리</a></li>
        <li class="sub" id="no2"><a href="${pageContext.request.contextPath}/book/bookView.do">도서관리</a></li>
        <li class="sub" id="no3"><a href="${pageContext.request.contextPath}/member/memberView.do">회원관리</a></li>
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title"></div>
    
    <div style="width:1200px;">
	    <div style="float:left; background:none; width:50%; border: 0;">
            <div class="ui-dialog-content ui-widget-content loan_content" style="margin: 5px; background: none; border: 1;">
	            <table>
	                <colgroup>
	                    <col style="width:15%;" />
	                    <col style="width:15%;" />
	                    <col style="width:15%;" />
	                    <col style="width:15%;" />
	                    <col style="width:15%;" />
	                    <col style="width:25%;" />
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th class="ui-corner-all">고객번호</th>
	                        <td><input class="text" type="text" style="width:90%" id="m_no" name="m_no" /></td>
	                        <th class="ui-corner-all">고객명</th>
	                        <td><input class="text" type="text" style="width:90%" id="m_name" name="m_name" /></td>
	                        <th class="ui-corner-all">전화번호</th>
	                        <td><input class="text" type="text" style="width:90%" id="m_phone_no" name="m_phone_no" /></td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
			<table id="listMember">
                <tbody>
                    <tr>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <p></p>	       
            <table id="listHistory">
                <tbody>
                    <tr>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <div id="hpager"></div>
	       
	    </div>
	    <div style="float:right; background:none; width:50%; border: 0;">
            <div class="ui-dialog-content ui-widget-content loan_content" style="margin: 5px; background: none; border: 1;">
                <table>
                    <colgroup>
                        <col style="width:15%;" />
                        <col style="width:15%;" />
                        <col style="width:15%;" />
                        <col style="width:25%;" />
                        <col style="width:15%;" />
                        <col style="width:15%;" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th class="ui-corner-all">도서번호</th>
                            <td><input class="text" type="text" style="width:90%" id="m_book_no" name="m_book_no" /></td>
                            <th class="ui-corner-all">도서제목</th>
                            <td><input class="text" type="text" style="width:90%" id="m_title" name="m_title" /></td>
                            <th class="ui-corner-all">도서저자</th>
                            <td><input class="text" type="text" style="width:90%" id="m_author" name="m_author" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <table id="listBook">
                <tbody>
                    <tr>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <div id="bpager"></div>
	    
	    </div>
	</div>
</div>


</body>
</html>