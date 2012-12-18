<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c-rt.tld"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    
    <title>로그인</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <link href="${pageContext.request.contextPath}/css/redmond/jquery-ui-1.9.1.custom.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-3.8.2/ui.jqgrid.css" type="text/css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/jqGrid-3.8.2/ui.multiselect.css" type="text/css" rel="stylesheet">

    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.1.custom.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-3.8.2/ui.multiselect.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-3.8.2/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jqGrid-3.8.2/jquery.jqGrid.min.js"></script>

    <script type="text/javascript">
        //<![CDATA[
        $(document).ready(function () {
            var mydata = [
                    {id:"1", invdate:"2007-10-01",name:"test",  note:"note",  amount:"200.00",tax:"10.00",closed:true, ship_via:"TN",total:"210.00"},
                    {id:"2", invdate:"2007-10-02",name:"test2", note:"note2", amount:"300.00",tax:"20.00",closed:false,ship_via:"FE",total:"320.00"},
                    {id:"3", invdate:"2007-09-01",name:"test3", note:"note3", amount:"400.00",tax:"30.00",closed:false,ship_via:"FE",total:"430.00"},
                    {id:"4", invdate:"2007-10-04",name:"test4", note:"note4", amount:"200.00",tax:"10.00",closed:true ,ship_via:"TN",total:"210.00"},
                    {id:"5", invdate:"2007-10-31",name:"test5", note:"note5", amount:"300.00",tax:"20.00",closed:false,ship_via:"FE",total:"320.00"},
                    {id:"6", invdate:"2007-09-06",name:"test6", note:"note6", amount:"400.00",tax:"30.00",closed:false,ship_via:"FE",total:"430.00"},
                    {id:"7", invdate:"2007-10-04",name:"test7", note:"note7", amount:"200.00",tax:"10.00",closed:true ,ship_via:"TN",total:"210.00"},
                    {id:"8", invdate:"2007-10-03",name:"test8", note:"note8", amount:"300.00",tax:"20.00",closed:false,ship_via:"FE",total:"320.00"},
                    {id:"9", invdate:"2007-09-01",name:"test9", note:"note9", amount:"400.00",tax:"30.00",closed:false,ship_via:"TN",total:"430.00"},
                    {id:"10",invdate:"2007-09-08",name:"test10",note:"note10",amount:"500.00",tax:"30.00",closed:true ,ship_via:"TN",total:"530.00"},
                    {id:"11",invdate:"2007-09-08",name:"test11",note:"note11",amount:"500.00",tax:"30.00",closed:false,ship_via:"FE",total:"530.00"},
                    {id:"12",invdate:"2007-09-10",name:"test12",note:"note12",amount:"500.00",tax:"30.00",closed:false,ship_via:"FE",total:"530.00"}
                ],
                grid = $("#list");

            grid.jqGrid({
                datatype:'local',
                data: mydata,
                colNames:['Inv No','Date','Client','Amount','Tax','Total','Closed','Shipped via','Notes'],
                colModel:[
                    {name:'id',index:'id',width:70,align:'center',sorttype: 'int'},
                    {name:'invdate',index:'invdate',width:80, align:'center', sorttype:'date', formatter:'date', formatoptions: {newformat:'d-M-Y'}, datefmt: 'd-M-Y'},
                    {name:'name',index:'name', width:70},
                    {name:'amount',index:'amount',width:100, formatter:'number', align:'right'},
                    {name:'tax',index:'tax',width:70, formatter:'number', align:'right'},
                    {name:'total',index:'total',width:120, formatter:'number', align:'right'},
                    {name:'closed',index:'closed',width:110,align:'center', formatter:'checkbox', edittype:'checkbox',editoptions:{value:'Yes:No',defaultValue:'Yes'}},
                    {name:'ship_via',index:'ship_via',width:120,align:'center',formatter:'select', edittype:'select',editoptions:{value:'FE:FedEx;TN:TNT;IN:Intim',defaultValue:'Intime'}},
                    {name:'note',index:'note',width:100,sortable:false}
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
        });
        //]]>
        
        $(function() {
            $("button").button();
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
		.grid_box .g_areaR {float:right !important; padding:4px 5px 5px 0; _padding:4px 5px 2px 0; color:#495b88; text-align:right;}
        
		.table_insert {clear: both; table-layout:fixed; padding:0; margin:0;}
		.table_insert table {width:1000px; border-collapse:collapse; padding:0; table-layout:fixed; border:1px solid #dedede;}
		
		.table_insert table tbody th {background:#eaf4fe; padding:7px 10px; _padding:8px 10px 6px 10px; border-left:1px solid #dedede; border-right:1px solid #dedede; border-bottom:1px solid #dedede; color:#0a0a0a; font-size: 12px; font-weight:normal; text-align:left; vertical-align:middle;}
		.table_insert table tbody td {background:#ffffff; padding:3px 10px 2px 10px; border-bottom:1px solid #dedede; color:#8e8e8e; vertical-align:middle;}
		.table_insert table tbody td img {vertical-align:middle;}
		.table_insert table tbody td select {font-size:12px; color:#8e8e8e;}
		.table_insert table tbody td label {margin:0 5px 0 0;cursor:pointer;}
		.table_insert table tbody td textarea {margin:3px 0;}
        
    </style>
    
    
</head>

<body>

    <div align=center>
        <div class="table_insert">
		    <table summary="사은품 관리 조회">
		      <caption> 사은품 관리 조회 </caption>
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
		          <th>지급시작일자</th>
		          <td><input class="inputtxt" type="text" title="" name="" style="width:20%;" /> ~ <input class="inputtxt" type="text" title="" name="" style="width:20%;" /></td>
		          <th>사은품관리명</th>
		          <td><input class="inputtext" type="text" title="사은품관리명" name="" style="width:65%;" /></td>
                  <th>지급시작일자</th>
                  <td><input class="inputtxt" type="text" title="" name="" style="width:20%;" /> ~ <input class="inputtxt" type="text" title="" name="" style="width:20%;" /></td>
                  <th>사은품관리명</th>
                  <td><input class="inputtext" type="text" title="사은품관리명" name="" style="width:65%;" /></td>
		        </tr>
		        <tr>
		          <th>사용여부</th>
		          <td><select>
		              <option>:: 전체 ::</option>
		            </select></td>
		          <th>온라인여부</th>
		          <td><select>
		              <option>:: 전체 ::</option>
		            </select></td>
                  <th>사용여부</th>
                  <td><select>
                      <option>:: 전체 ::</option>
                    </select></td>
                  <th>온라인여부</th>
                  <td><select>
                      <option>:: 전체 ::</option>
                    </select></td>
		        </tr>
		      </tbody>
		    </table>
        </div>
        
        <div class="grid_box clfix">
            <div class="g_areaR clfix">
                <button>회원조회</button>
            </div>
            <div class="g_areaL clfix">
                <button>회원등록</button>
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


</body>
</html>