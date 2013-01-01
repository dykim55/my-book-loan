<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "com.company.util.CodeSelect;" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>대출현황</title>
    
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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/utils.js"></script>
    
    <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function () {

            $("#m_sdt").val(format_YYYYMMDD(shiftTime(getCurrentDay(), 0,-1,0,0),"-"));
            $("#m_edt").val(format_YYYYMMDD(getCurrentDay(),"-"));
        	
        	grid = $("#listHistory");
        	
            grid.jqGrid({
            	url:"${pageContext.request.contextPath}/present/searchLoanHistory.ajax",
            	postData:{
                    m_sdt:$("#m_sdt").val(),
                    m_edt:$("#m_edt").val()
                },            	
                datatype: "json",
                mtype: 'POST',
                colNames:['대출일시','상태','도서번호','제   목','저   자','출판사','회원번호','회원명','집전화번호','휴대폰번호','회수완료일','회수예정일','회수타입'],
                colModel:[
                    {name:'m_loan_dt',     index:'m_loan_dt',     width:16, align:'center', formatter:dateFormatter}, 
                    {name:'m_status',      index:'m_status',      width:8,  align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("003") %>'}},
                    {name:'m_book_no',     index:'m_book_no',     width:8,  align:'center'},
                    {name:'m_title',       index:'m_title',       width:26, align:'left', cellattr: function (rowId, val, rawObject, cm, rdata) { return 'title="저   자: ' + rawObject.m_author + '\n출판사: ' + rawObject.m_publisher + '"'; }},
                    {name:'m_author',      index:'m_author',      width:0,  align:'center', hidden:true},
                    {name:'m_publisher',   index:'m_publisher',   width:0,  align:'center', hidden:true},
                    {name:'m_no',          index:'m_no',          width:10, align:'center'}, 
                    {name:'m_name',        index:'m_name',        width:10, align:'center'},
                    {name:'m_tel_no',      index:'m_tel_no',      width:14, align:'center', formatter:phoneFormatter},
                    {name:'m_cell_no',     index:'m_cell_no',     width:14, align:'center', formatter:phoneFormatter},
                    {name:'m_real_rcv_dt', index:'m_real_rcv_dt', width:16, align:'center', formatter:dateFormatter},
                    {name:'m_rcv_plan_dt', index:'m_rcv_plan_dt', width:10, align:'center', formatter:dateFormatter},
                    {name:'m_rcv_tp',      index:'m_rcv_tp',      width:10, align:'center', formatter:'select',  edittype:'select', editoptions: {value: '<%=CodeSelect.makeEditOption("006") %>'}}
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
                width: '1200',
                loadComplete: function() {
                    var rowIDs = $(this).getDataIDs(); 
                    for (var i=0;i<rowIDs.length;i=i+1) { 
                        rowData=$(this).getRowData(rowIDs[i]);
                        var trElement = jQuery("#"+ rowIDs[i],$(this));
                        if (rowData.m_status == '3') {
                            trElement.removeClass('ui-widget-content');
                            trElement.addClass('mStatus3');
                        }
                        
                        if (getDayInterval(rowData.m_loan_dt.replace(/\-/g,'').substring(0,8), getCurrentDay()) <= 1) {
                            trElement.removeClass('ui-widget-content');
                            trElement.addClass('mToday');
                        }
                    }
                },
                ondblClickRow: function (rowid, iRow, iCol, e) {
                    $("#m_no").val(grid.getCell(rowid, 7));
                    $('#frm').attr("action", "${pageContext.request.contextPath}/loan/loanView.do" );
                    $('#frm').submit();                      
                }                
            });

            $('#m_sdt, #m_edt, #m_rcv_plan_dt, #m_search_value').keydown(function(e) {
                if (e.keyCode==13) {
                	reloadGrid();
                    return false;
                }
            });
            
            $("#m_sdt, #m_edt, #m_rcv_plan_dt, #m_search_value").focus(function(event) {
                $('#'+event.target.id).select();
            });
            
            $("#m_sdt, #m_edt, #m_rcv_plan_dt, #m_status, #m_rcv_tp").change(function() {
            	if (getDayInterval($("#m_sdt").val().replace(/\-/g,''), $("#m_edt").val().replace(/\-/g,'')) < 1) {
            	    alert("조회기간이 잘못됐습니다. 조회 종료일이 시작일보다 작습니다.");
            	    return;
            	}
            	reloadGrid();
            });
            
            //회원조회
            $("#onBtnSch").click(function () {
            	reloadGrid();
            });
            
            $("#onBtnExcel").click(function () {
                $('#frm').attr("action", "${pageContext.request.contextPath}/present/searchLoanHistoryExcel.do" );
                $('#frm').submit();                      
            });

            
            
        });
        //]]>
        
        $(function() {
            $("button").button();
            $("#m_sdt, #m_edt, #m_rcv_plan_dt").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-10:c',
                dateFormat: 'yy-mm-dd',
                monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
            });            
        });
        
         function reloadGrid () {
             grid.jqGrid('setGridParam',    {
                 page:1
                 ,postData:{
                     m_sdt:$("#m_sdt").val(),
                     m_edt:$("#m_edt").val(),
                     m_rcv_plan_dt:$("#m_rcv_plan_dt").val(),
                     m_search_tp:$("#m_search_tp").val(),
                     m_search_value:$("#m_search_value").val(),
                     m_status:$("#m_status").val(),
                     m_rcv_tp:$("#m_rcv_tp").val()
                 }
             }).trigger("reloadGrid");
        }
        
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
        <li class="sub" id="no1"><a class="select" href="#">대출현황</a></li>
        <li class="sub" id="no2"><a href="${pageContext.request.contextPath}/loan/loanView.do">대출관리</a></li>
        <li class="sub" id="no3"><a href="${pageContext.request.contextPath}/book/bookView.do">도서관리</a></li>
        <li class="sub" id="no4"><a href="${pageContext.request.contextPath}/member/memberView.do">회원관리</a></li>
        <li class="sub" id="no5"><a href="#">시스템설정</a></li>
    </ul>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/hover_menu5.js"></script> 

<div align=center>

    <div class="title"></div>
    
    <form id="frm" name="frm" method="post" action="">
    <input type="hidden" id="m_no" name="m_no" />
    <div style="width:1200px;">
	    <div style="position: relative; height: 32px;" class="ui-widget">
	        <div class="ui-dialog-content ui-widget-content search_box" style="background: none; border: 0;">
	            <table>
	                <colgroup>
	                    <col style="width:8%;" />
	                    <col style="width:16%;" />
                        <col style="width:8%;" />
                        <col style="width:8%;" />
                        <col style="width:8%;" />
                        <col style="width:20%;" />
                        <col style="width:8%;" />
                        <col style="width:8%;" />
                        <col style="width:8%;" />
                        <col style="width:8%;" />
                        
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th>대출기간</th>
	                        <td><input class="text" type="text" style="width:42%" id="m_sdt" name="m_sdt" readonly/>&nbsp;~&nbsp;<input class="text" type="text" style="width:42%" id="m_edt" name="m_edt" readonly/></td>
	                        <th>회수예정일</th>
	                        <td><input class="text" type="text" style="width:100%" id="m_rcv_plan_dt" name="m_rcv_plan_dt" /></td>
	                        <th>
	                            <select id="m_search_tp">
	                                <option value='1'>도서제목</option>
	                                <option value='2'>회원명</option>
	                                <option value='3'>전화번호</option>
	                            </select>
	                        </th>
	                        <td><input class="text" type="text" style="width:100%" id="m_search_value" name="m_search_value" /></td>
	                        <th>대출상태</th>
	                        <td><%=CodeSelect.makeCodeSelect("m_status", "::전체::", "003", "") %></td>
	                        <th>회수형태</th>
	                        <td><%=CodeSelect.makeCodeSelect("m_rcv_tp", "::전체::", "006", "") %></td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	    </div>
    
	    <div class="grid_box clfix">
	        <div class="g_areaR clfix">
	            <button id="onBtnSch">현황조회</button>
	            <button id="onBtnExcel">엑셀저장</button>
	        </div>
	    </div>
    
        <div style="padding:5px 0px 5px 0px; background:none; border: 0;">
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
    </form>

</div>

</body>
</html>