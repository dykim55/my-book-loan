<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-Transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Sample</title>
    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css" />
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/redmond/jquery-ui-1.9.1.custom.min.css" />
    <!-- link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hot-sneaks/jquery-ui-1.8.21.custom.css" / -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-1.8.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.9.1.custom.min.js"></script>
    <!-- script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery-ui-1.8.21.custom.min.js"></script -->
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/coGrid/jquery.coGrid-0.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery/jquery.blockUI.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/json2.js"></script>
    
    <link href="${pageContext.request.contextPath}/js/coGrid/jquery.coGrid-0.1.css" rel="stylesheet" type="text/css"/>    
    
    <script>
    
    var contextPath = "${pageContext.request.contextPath}";
    
    $(function() {
    	$("#tabs").tabs();    	
    });
    
    $(document).ready(function() {
        
        //발급내역그리드
        $("#grid").coGrid({
            head : [
                    {id:"PAGING_RNUM",         type:"text",   width:50,  name:"순번"},
                    {id:"issue_date",          type:"text",   width:140, name:"발급일자"},
                    {id:"m_no",                type:"text",   width:80,  name:"직원번호", formatter:linkDetailformatter},
                    {id:"m_name",              type:"text",   width:150,  name:"직원명"},
                    {id:"issue_m_name_en",     type:"text",   width:150, name:"직원영문명"},
                    {id:"issue_department",    type:"text",   width:150, name:"부서명"},
                    {id:"issue_department_en", type:"text",   width:150, name:"영문부서명"},
                    {id:"issue_group_en",      type:"text",   width:60,  name:"직종</br>코드"},
                    {id:"issue_card_type",     type:"select", width:60,  name:"카드</br>종류", selector : [['PVC','IC','RF','스티커'],['1','2','3','4']]},
                    {id:"issue_count",         type:"text",   width:50,  name:"발급</br>차수"},
                    {id:"issue_status",        type:"select", width:60,  name:"카드상태", selector : [['정상','사용중지','재발급요청'],['N','L','R']] },
                    {id:"issue_sno",           type:"text",   width:100,  name:"카드번호"}
                    ],
            rowNums : [20,50,100],
            rowNum: 20,
            rowCount: false,
            checkbox: true,
            paging : true,
            height : 550,
            scrollbar : true
        });

        $("#onSearchBtn").click(function(){
            $("#grid").coGrid("load",{
                url  : "${pageContext.request.contextPath}/sample/sampleSearch.ajax",
                form : "#searchFrm"
                });
            return false;
        });
        
        $("tbody","#grid").click(function(e){
        	var rowNo = $(e.target).parents("tr").attr("rowNo");

        	if ($(e.target)[0].className == "col_check" && $(e.target)[0].checked) {
        	    $("#grid").coGrid("highlight", rowNo);
        	} else if ($(e.target)[0].className == "col_check" && !$(e.target)[0].checked) {
        		$("#grid").coGrid("highlight", rowNo, false);	
        	}
            
            var data = $("#grid").coGrid("getRowData", rowNo);
            
            alert(data.issue_date + " : " + $(e.target)[0].innerText);
            
        });
        
        function linkDetailformatter (rowNo, colId, data) {
            return "<a style='color:#666; text-decoration:underline;' href='javascript:alert(\""+rowNo+"\");'>" + data + "</a>";
        }
        
        $("#grid").ajaxStart(function() {
            $(this).block({ 
                message: 'Loading...' 
            }); 
        }).ajaxStop(function() {
            $(this).unblock();
        });
        
        
    });        
    </script>
    
</head>
<body>

<div class="ui-widget">
    <div id="alert" class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 10px;">
        <p>Sample ui-state-highlight style.</p>
    </div>
</div>

<button id="onSearchBtn">A button element</button>

    <form action="" method="post" id='searchFrm' name='searchFrm'>
        <table border=1px>
            <colgroup>
                <col width="8%" />
                <col width="28%" />
                <col width="8%" />
                <col width="14%" />
                <col width="8%" />
                <col width="14%" />
                <col width="8%" />
                <col width="12%" />
            </colgroup>
            <tr>
                <th>발급일자</th>
                <td><input class="w80" type="text" id="p_s_date" name="p_s_date" readonly value="" />&nbsp;~&nbsp;<input class="w80" type="text" id="p_e_date" name="p_e_date" readonly value="" /></td>
                <th>카드종류</th>
                <td><select id="p_card_type" name="p_card_type" >
                        <option value=''>전체</option>
                        <option value='1'>PVC</option>
                        <option value='2'>IC</option>
                        <option value='3'>RF</option>
                        <option value='4'>스티커</option>
                    </select></td>
                <th>직원번호</th>
                <td><input class="w80" type="text" id="p_m_no" name="p_m_no" value="" style="ime-mode:disabled;" maxlength='10'/></td>
                <th>직원명</th>
                <td><input class="w80" type="text" id="p_m_name" name="p_m_name" value="" maxlength='50'/></td>
            </tr>
            <tr>
                <th>소속부서</th>
                <td><!-- <input class="w50" type="text" id="p_dp_code" name="p_dp_code" />&nbsp; --><input class="w160" type="text" id="p_dp_name" name="p_dp_name" value="" /><!-- <a href="#"  id="onInitInput"><img style="padding:2px 2px; vertical-align:middle;" src="${pageContext.request.contextPath}/images/ico_init.gif"/></a> --></td>
                <th>직종</th>
                <td><input class="w80" type="text" id="p_group_en" name="p_group_en" value="" style="ime-mode:disabled;"/></td>
                <th>카드상태</th>
                <td><select id="p_st_code" name="p_st_code" >
                        <option value=''>전체</option>
                        <option value='N'>정상</option>
                        <option value='L'>사용중지</option>
                        <option value='R'>재발급요청</option>
                    </select></td>
                <th>발급차수</th>
                <td><input class="w80" type="text" id="p_issue_count" name="p_issue_count" value="" /></td>
            </tr>
            
        </table>
    </form>

    <div id="grid"></div>
    
</body>
</html>
