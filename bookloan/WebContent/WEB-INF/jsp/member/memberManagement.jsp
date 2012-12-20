<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>로그인</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link href="${pageContext.request.contextPath}/css/pepper-grinder/jquery-ui-1.9.1.custom.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-3.8.2/ui.jqgrid.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-3.8.2/ui.multiselect.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/pro_dropdown_3.css" type="text/css" rel="stylesheet">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-3.8.2/ui.multiselect.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-3.8.2/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-3.8.2/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/stuHover.js"></script>

    <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function () {
            var mydata = [
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"},
                    {m_area:"1", m_no:"999999", m_name:"홍길동",  m_birth_dt:"19730205",  m_calr_tp:"1", m_tel_no:"0222939696", m_cell_no:"01023696985", m_addr:"서울특별시 노원구 공릉2동 화랑타운아파트", m_email:"gildonghong@hotmail.com"}
                ],
                grid = $("#list");

            grid.jqGrid({
                datatype:'local',
                data: mydata,
                colNames:['주민센터','고객번호','고객명','생년월일','월력','전화번호','휴대폰번호','주소','이메일'],
                colModel:[
                    {name:'m_area',index:'id',width:60,align:'center',sorttype: 'int'},
                    {name:'m_no',index:'invdate',width:60, align:'center'}, 
                    {name:'m_name',index:'name', width:60},
                    {name:'m_birth_dt',index:'amount',width:60, align:'right'},
                    {name:'m_calr_tp',index:'tax',width:40, align:'right'},
                    {name:'m_tel_no',index:'total',width:80, align:'right'},
                    {name:'m_cell_no',index:'closed',width:80,align:'center'},
                    {name:'m_addr',index:'ship_via',width:160,align:'center'},
                    {name:'m_email',index:'note',width:160,sortable:false}
                ],
                rowNum:10,
                rowList:[5,10,20],
                pager: '#pager',
                gridview:true,
                rownumbers:true,
                sortname: 'invdate',
                viewrecords: true,
                sortorder: 'desc',
                caption:'Just simple local grid',
                height: '100%',
                width: '1000'
            });
            grid.jqGrid ('navGrid', '#pager',
                         {edit:false, add:false, del:false, refresh:true, view:false},
                         {},{},{},{multipleSearch:true,overlay:false});
            
            //#pager에 button을 추가한다.
            grid.jqGrid ('navButtonAdd', '#pager', {
                caption: "", buttonicon: "ui-icon-calculator", title: "choose columns",
                onClickButton: function() {
                    //Select columns창을 띄운다.
                    grid.jqGrid('columnChooser');
                }
            });

            $( "#dialog-form-registration" ).dialog({
                autoOpen: false,
                width: 600,
                modal: true,
                buttons: {
                    "등록": function() {
                    	alert("등록");
                    },
                    "취소": function() {
                        $( this ).dialog( "close" );
                    }
                },
                close: function() {
                }
            });

            $( "#dialog-form-modify" ).dialog({
                autoOpen: false,
                height: 300,
                width: 350,
                modal: true,
                buttons: {
                    "수정": function() {
                    	alert("수정");
                    },
                    "취소": function() {
                        $( this ).dialog( "close" );
                    }
                },
                close: function() {
                }
            });
            
           
            $("#onBtnReg").click(function () {
                $("#dialog-form-registration").dialog("open");
            });
            
            $("#onBtnMdf").click(function () {
                $("#dialog-form-modify").dialog("open");
            });
            
            
        });
        //]]>
        
        $(function() {
            $("button").button();
            $("#combobox").combobox();
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
		.ui-dialog-content table tbody th {background:#fff url(../css/pepper-grinder/images/ui-bg_fine-grain_15_ffffff_60x60.png) repeat-x; padding:7px 10px; _padding:8px 10px 6px 10px; border-left:1px solid #dedede; border-right:1px solid #dedede; border-bottom:1px solid #dedede; color:#0a0a0a; font-size: 12px; font-weight:normal; text-align:left; }
		.ui-dialog-content table tbody td {background:none; padding:1px 10px 2px 10px; border-bottom:0px solid #dedede; color:#8e8e8e; text-align:left;}
		.ui-dialog-content table tbody td input {height: 20px; font-family: "맑은 고딕", MalgunGothic, Lucida Grande,Lucida Sans,Arial,sans-serif; font-size: 12px; vertical-align:middle;}
		.ui-dialog-content table tbody td select {height: 20px; font-size:12px; color:#8e8e8e;font-family:"맑은 고딕", MalgunGothic}

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

    <ul id="nav">
        <li class="top"><a href="#nogo1" class="top_link on"><span>회원관리</span></a></li>
        <li class="top"><a href="#nogo1" class="top_link"><span>도서관리</span></a></li>
        <li class="top"><a href="#nogo1" class="top_link"><span>대여관리</span></a></li>
    </ul>

    <div align=center>
        
        <div style="position: relative; width: 1000px; height: 63px;" class="ui-widget">
            <div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
            <table>
              <colgroup>
                <col style="width:10%;" />
                <col style="width:15%;" />
                <col style="width:10%;" />
                <col style="width:15%;" />
                <col style="width:10%;" />
                <col style="width:15%;" />
                <col style="width:10%;" />
                <col style="width:15%;" />
              </colgroup>
              <tbody>
                <tr>
                  <th class="ui-corner-all">주민센터</th>
                  <td><select>
                      <option>:: 전체 ::</option>
                      <option>휘경2동</option>
                    </select></td>
                  <th class="ui-corner-all">고객번호</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                  <th class="ui-corner-all">고객명</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                  <th class="ui-corner-all">주민번호</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                </tr>
                <tr>
                <td colspan="8"></td>
                </tr>
                <tr>
                  <th class="ui-corner-all">생년월일</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                  <th class="ui-corner-all">전화번호</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                  <th class="ui-corner-all">휴대폰번호</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                  <th class="ui-corner-all">이메일</th>
                  <td><input class="text ui-corner-all" type="text" name="" /></td>
                </tr>
              </tbody>
            </table>
            </div>
        </div>
    
        <div class="grid_box clfix">
            <div class="g_areaR clfix">
                <button>회원조회</button>
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
	    <div class="ui-dialog-content ui-widget-content" style="background: none; border: 0;">
	    <table style="width:500px">
	      <colgroup>
	        <col style="width:20%;" />
	        <col style="width:80%;" />
	      </colgroup>
	      <tbody>
	        <tr>
	          <th class="ui-corner-all">고객명</th>
	          <td><input class="text ui-corner-all" style="width:50%" type="text" name="" /></td>
	        </tr>
	        <tr>
	          <th class="ui-corner-all">주민번호</th>
	          <td><input class="text ui-corner-all" style="width:50%" type="text" name="" /></td>
	        </tr>
            <tr>
              <th class="ui-corner-all">생년월일</th>
              <td><input class="text ui-corner-all" style="width:50%" type="text" name="" /></td>
            </tr>
            <tr>
              <th class="ui-corner-all">전화번호</th>
              <td><input class="text ui-corner-all" style="width:50%" type="text" name="" /></td>
            </tr>
            <tr>
              <th class="ui-corner-all">휴대폰번호</th>
              <td><input class="text ui-corner-all" style="width:50%" type="text" name="" /></td>
            </tr>
            <tr>
              <th class="ui-corner-all">이메일</th>
              <td><input class="text ui-corner-all" style="width:50%" type="text" name="" /></td>
            </tr>
            <tr>
              <th class="ui-corner-all">주소</th>
              <td><input class="text ui-corner-all" style="width:100%" type="text" name="" /></td>
            </tr>
            <tr>
              <th class="ui-corner-all">비고</th>
              <td><input class="text ui-corner-all" style="width:100%" type="text" name="" /></td>
            </tr>
            
	      </tbody>
	    </table>
	    </div>
    </form>

</div>

<div id="dialog-form-modify" title="회원수정">
    <div class="popupContenet">
        <div align="center" class="bdCtrl">
            <a href="#" id="onRegSaveBtn" class="btn"><span>저장</span></a>
        </div>
    </div>
    
    <!-- button area -->
    <div class="btnClose">
        <a id="onPopupRegCloseBtn"  href="#">닫기</a>
    </div>
</div>

</body>
</html>