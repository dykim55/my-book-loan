<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "com.company.util.CodeSelect;" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>대출관리</title>
    
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

        	gridM = $("#listMember");
        	gridB = $("#listBook");
        	gridH = $("#listHistory");
        	
        	gridM.jqGrid({
            	datatype: "json",
            	mtype: 'POST',
            	colNames:['회원번호','회원명','성별','생년월일','전화번호','휴대폰번호','주   소',''],
                colModel:[
                    {name:'m_no',       index:'m_no',       width:10,   align:'center'}, 
                    {name:'m_name',     index:'m_name',     width:10,   align:'center'},
                    {name:'m_gender',   index:'m_gender',   width:5,   align:'center', formatter:'select',  edittype:'select', editoptions: {value: '1:남;2:여', defaultValue:'남'}},
                    {name:'m_birth_dt', index:'m_birth_dt', width:12,   align:'center', formatter:dateFormatter},
                    {name:'m_tel_no',   index:'m_tel_no',   width:13,   align:'center', formatter:phoneFormatter},
                    {name:'m_cell_no',  index:'m_cell_no',  width:13,   align:'center', formatter:phoneFormatter},
                    {name:'m_addr',     index:'m_addr',     width:37,   align:'left'},
                    {name:'m_loan_cnt', index:'m_loan_cnt', width:0,    align:'center', hidden:true}
                ],
                jsonReader : {
                	repeatitems:false
                },
                rowNum:10,
                rowList:[10,20,50],
                pager: '#mpager',
                viewrecords: true,
                rownumbers:true,
                forceFit : true,
                caption:'회원정보',
                height: '100%',
                width: '780',
                loadComplete: function () {
                    var count = gridM.jqGrid('getGridParam','reccount');
                    if (count == 1) {
                        gridH.jqGrid('setGridParam',    {
                        	url:"${pageContext.request.contextPath}/loan/searchLoanHistory.ajax"
                        	,page:1
                            ,postData:{
                                m_no:gridM.getCell(1, 1)
                            }
                        }).trigger("reloadGrid");
                        $("#mpager").hide();
                    } else {
                    	gridH.jqGrid('clearGridData');
                    	$("#mpager").show();
                    }
                },
                ondblClickRow: function (rowid, iRow, iCol, e) {
                    gridM.jqGrid('setGridParam', {
                    	page:1
                        ,postData:{
                            m_no:gridM.getCell(iRow, 1)
                        }
                    }).trigger("reloadGrid");
                }                
            });
			
            gridB.jqGrid({
                datatype: "json",
                mtype: 'POST',
                colNames:['상태','도서번호','제  목','저  자','회수예정일','','회원'],
                colModel:[
                    {name:'m_loan_st',     index:'m_loan_st',     width:40,  align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("003") %>'}},      
                    {name:'m_book_no',     index:'m_book_no',     width:60,  align:'center'}, 
                    {name:'m_title',       index:'m_title',       width:120, align:'left'},
                    {name:'m_author',      index:'m_author',      width:80,  align:'center'},
                    {name:'m_rcv_plan_dt', index:'m_rcv_plan_dt', width:50,  align:'center', formatter:dateFormatter},
                    {name:'action',                               width:30,  align:'center', sortable: false,
                        formatter:function(cellval, opts, rwdat, _act) {
                        	if (rwdat.m_loan_st == "1") {
                        	    return "<span style=\"cursor:pointer;\"><u>대출</u></span>"
                        	} else {
                        		return "";
                        	}
                        }
                    },
                    {name:'m_no',       index:'m_no',       width:0, align:'left', hidden:true},
                ],
                jsonReader : {
                    repeatitems:false
                },
                rowNum:20,
                rowList:[10,20,50],
                pager: '#bpager',
                viewrecords: true,
                rownumbers:true,
                forceFit : true,
                caption:'도서정보',
                height: '100%',
                width: '780',
                loadComplete: function() {
                    var rowIDs = $(this).getDataIDs(); 
                    for (var i=0;i<rowIDs.length;i=i+1) { 
                        rowData=$(this).getRowData(rowIDs[i]);
                        var trElement = jQuery("#"+ rowIDs[i],$(this));
                        if (rowData.m_loan_st != '1') {
                            trElement.removeClass('ui-widget-content');
                            trElement.addClass('mStatus4');
                        }
                    }
                },                
                beforeSelectRow: function (rowid, e) {
                    var iCol = $.jgrid.getCellIndex(e.target);
                    if (iCol == 6) {
                    	if (gridB.getCell(rowid, iCol) != "") {
                    		var count = gridM.jqGrid('getGridParam','reccount');
                    		if (count > 1) {
                    			alert("대출대상 회원이 너무 많습니다.");
                    			return true;
                    		}
                    		
                    		count = gridM.getCell(1, 8);
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
	                                        alert(msg.err_message);
	                                        gridM.trigger("reloadGrid");
	                                        gridB.trigger("reloadGrid");
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
                	if (gridB.getCell(rowid, 7).length >= 6) {
	                    gridM.jqGrid('setGridParam', {
	                    	page:1
	                        ,postData:{
	                            m_no:gridB.getCell(iRow, 7)
	                        }
	                    }).trigger("reloadGrid");
                	}
                }                
            });
        	
            gridH.jqGrid({
                datatype: "json",
                mtype: 'POST',
                colNames:['대출일시','상태','도서번호','제   목','저   자','출판사','회수완료일','회수예정일','회수','연장'],
                colModel:[
                    {name:'m_loan_dt',     index:'m_loan_dt',     width:16,  align:'center', formatter:dateFormatter}, 
                    {name:'m_status',      index:'m_status',      width:8,  align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("003") %>'}},
                    {name:'m_book_no',     index:'m_book_no',     width:8,  align:'center'},
                    {name:'m_title',       index:'m_title',       width:26,  align:'left', cellattr: function (rowId, val, rawObject, cm, rdata) { return 'title="저   자: ' + rawObject.m_author + '\n출판사: ' + rawObject.m_publisher + '"'; }},
                    {name:'m_author',      index:'m_author',      width:0,  align:'center', hidden:true},
                    {name:'m_publisher',   index:'m_publisher',   width:0,  align:'center', hidden:true},
                 /* {name:'m_genre',       index:'m_genre',       width:0,  align:'center', hidden:true, formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("004") %>'}}, */
                    {name:'m_real_rcv_dt', index:'m_real_rcv_dt', width:16,  align:'center', formatter:dateFormatter},
                    {name:'m_rcv_plan_dt', index:'m_rcv_plan_dt', width:10,  align:'center', formatter:dateFormatter},
                    {name:'action',                               width:8,  align:'center', sortable: false,
                        formatter:function(cellval, opts, rwdat, _act) {
                            if (rwdat.m_status >= "2") {
                                return "<span style=\"cursor:pointer;\"><u>회수처리</u></span>"
                            } else {
                                return "";
                            }
                        }
                    },
                    {name:'action',                               width:8,  align:'center', sortable: false,
                        formatter:function(cellval, opts, rwdat, _act) {
                            if (rwdat.m_status >= "2") {
                                return "<span style=\"cursor:pointer;\"><u>연장처리</u></span>"
                            } else {
                                return "";
                            }
                        }
                    }
                ],
                jsonReader : {
                    repeatitems:false
                },
                rowNum:20,
                rowList:[10,20,50],
                pager: '#hpager',
                rownumbers:true,
                viewrecords: true,
                forceFit : true,
                caption:'대출이력정보',
                height: '100%',
                width: '780',
                beforeSelectRow: function (rowid, e) {
                    var iCol = $.jgrid.getCellIndex(e.target);
                    var confirmMsg = "";
                    var vRcvType = "";
                    
                    if (iCol < 9) { return true; }

                    if (iCol == 9) {//회수
                        if (gridH.getCell(rowid, iCol) != "") {
                        	confirmMsg = "회수처리를 하시겠습니까?";
                            vRcvType="1";
                        }
                    }
                    if (iCol == 10) {//연장
                        if (gridH.getCell(rowid, iCol) != "") {
                        	confirmMsg = "대출연장을 하시겠습니까?";
                        	vRcvType="2";
                        }
                    }

                    if (vRcvType != "" && confirm(confirmMsg)) {
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/loan/updateReceiveLoan.ajax",
                            data: {
                            	m_no:gridM.getCell(1, 1),
                            	m_loan_dt:gridH.getCell(rowid, 1),
                                m_book_no:gridH.getCell(rowid, 3),
                                m_rcv_tp:vRcvType
                            }, 
                            dataType: "json",
                            success: function(msg){
                                if (msg.err_code=="0000") {
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
                    
                    return false;
                },
                loadComplete: function() {
                    var rowIDs = $(this).getDataIDs(); 
                    for (var i=0;i<rowIDs.length;i=i+1) { 
                        rowData=$(this).getRowData(rowIDs[i]);
                        var trElement = jQuery("#"+ rowIDs[i],$(this));
                        if (rowData.m_status == '3') {
                            trElement.removeClass('ui-widget-content');
                            trElement.addClass('mStatus3');
                        } else if (rowData.m_status == '2') {
                            trElement.removeClass('ui-widget-content');
                            trElement.addClass('mStatus2');
                        }
                    }
                }                
            });
        	
            $('#m_no, #m_name, #m_phone_no').keydown(function(e) {
                if (e.keyCode==13) {
                    gridM.jqGrid('setGridParam',    {
                    	url:"${pageContext.request.contextPath}/loan/searchMemberInfo.ajax"
                    	,page:1
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
                	if ($("#m_title").val().length > 0 && $("#m_title").val().length < 2) {
            			alert("제목은 최소 두글자 이상으로 검색해 주세요.");
            			return;
            		}
                    gridB.jqGrid('setGridParam',    {
                    	url:"${pageContext.request.contextPath}/loan/searchBookInfo.ajax"
                    	,page:1
                        ,postData:{
                        	m_book_no:$("#m_book_no").val(), 
                        	m_title:$("#m_title").val(),
                        	m_author:$("#m_author").val()
                        }
                    }).trigger("reloadGrid");
                }
            });
            
            $("#m_no, #m_name, #m_phone_no,#m_title,#m_author,#m_book_no").focus(function(event) {
                $('#'+event.target.id).select();
            });
            
            gridM.jqGrid('setGridParam', {
            	url:"${pageContext.request.contextPath}/loan/searchMemberInfo.ajax"
                ,postData:{
                    m_no:'${m_no}' 
                }
            }).trigger("reloadGrid");
            
        });
        //]]>
        
        
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
        <li class="sub" id="no1"><a href="${pageContext.request.contextPath}/present/presentView.do">대출현황</a></li>
        <li class="sub" id="no2"><a class="select" href="#">대출관리</a></li>
        <li class="sub" id="no3"><a href="${pageContext.request.contextPath}/book/bookView.do">도서관리</a></li>
        <li class="sub" id="no4"><a href="${pageContext.request.contextPath}/member/memberView.do">회원관리</a></li>
        <li class="sub" id="no5"><a href="#">시스템설정</a></li>
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title"></div>
    
    <div style="width:1600px;">
	    <div style="float:left; background:none; width:50%; border: 0;">
            <div class="ui-dialog-content ui-widget-content search_box" style="margin: 15px; background:none; border: 0;">
	            <table>
	                <colgroup>
	                    <col style="width:14%;" />
	                    <col style="width:16%;" />
	                    <col style="width:14%;" />
	                    <col style="width:16%;" />
	                    <col style="width:14%;" />
	                    <col style="width:26%;" />
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th>회원번호</th>
	                        <td><input class="text" type="text" style="width:100%" id="m_no" name="m_no" value="${m_no}"/></td>
	                        <th>회원명</th>
	                        <td><input class="text" type="text" style="width:100%" id="m_name" name="m_name" /></td>
	                        <th>전화번호</th>
	                        <td><input class="text" type="text" style="width:100%" id="m_phone_no" name="m_phone_no" /></td>
	                    </tr>
	                </tbody>
	            </table>
            </div>
            <div style="padding:5px 0px 5px 0px; background:none; width:800px; border: 0;">
				<table id="listMember">
	                <tbody>
	                    <tr>
	                        <td></td>
	                    </tr>
	                </tbody>
	            </table>
            <div id="mpager"></div>
            </div>

		    <div style="padding:25px 0px 5px 0px; background:none; width:800px; border: 0;">
	            <table id="listHistory">
	                <tbody>
	                    <tr>
	                        <td></td>
	                    </tr>
	                </tbody>
	            </table>
	            <div id="hpager"></div>
	        </div>
	    </div>

	    <div style="float:right; background:none; width:50%; border: 0;">
            <div class="ui-dialog-content ui-widget-content search_box" style="margin: 15px; background: none; border: 0;">
                <table>
                    <colgroup>
                        <col style="width:14%;" />
                        <col style="width:16%;" />
                        <col style="width:14%;" />
                        <col style="width:26%;" />
                        <col style="width:14%;" />
                        <col style="width:16%;" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>도서번호</th>
                            <td><input class="text" type="text" style="width:100%" id="m_book_no" name="m_book_no" /></td>
                            <th>도서제목</th>
                            <td><input class="text" type="text" style="width:100%" id="m_title" name="m_title" /></td>
                            <th>도서저자</th>
                            <td><input class="text" type="text" style="width:100%" id="m_author" name="m_author" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div style="padding:5px 0px 5px 0px; background:none; width:800px; border: 0;">
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
</div>


</body>
</html>