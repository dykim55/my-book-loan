<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import= "com.cyberone.util.CodeSelect;" %>

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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/utils.js"></script>
    
    <link href="${pageContext.request.contextPath}/js/coGrid/jquery.coGrid-0.1.css" rel="stylesheet" type="text/css"/>    
    
    <script>
    
    var contextPath = "${pageContext.request.contextPath}";
    
    $(document).ready(function() {
        
        //발급내역그리드
        $("#grid").coGrid({
            head : [
                    {id:"PAGING_RNUM", type:"text",   width:40,  name:"순번"},
                    {id:"his_indt",    type:"text",   width:100, name:"발급일자", formatter:dateformatter},
                    {id:"his_idno",    type:"text",   width:80,  name:"학번", formatter:linkDetailformatter},
                    {id:"his_name",    type:"text",   width:80, name:"성명"},
                    {id:"his_psnm",    type:"text",   width:150, name:"학과"},
                    {id:"his_iddi",    type:"text",   width:80, name:"신분<br>구분"},
                    {id:"bas_grad",    type:"text",   width:50, name:"학년"},
                    {id:"his_isfg",    type:"text",   width:50, name:"발급<br>차수"},
                    {id:"his_rsco",    type:"text",   width:80,  name:"발급사유"},
                    {id:"his_iscg",    type:"text",   width:60,  name:"수수료", formatter:numberformatter},
                    {id:"his_sdco",    type:"text",   width:60,  name:"재적상태"}
                    ],
            rowNums : [20,50,100],
            rowNum: 20,
            rowCount: false,
            checkbox: false,
            paging : true,
            scrollbar : true
        });

        function linkDetailformatter (rowNo, colId, data) {
            return "<a style='color:#666; text-decoration:underline;' href='javascript:showDetailDialog(\""+data+"\");'>" + data + "</a>";
        }

        function dateformatter (rowNo, colId, data) {
            return format_YYYYMMDDHHMM(data);
        }

        function numberformatter (rowNo, colId, data) {
            return addComma(data, false);
        }

        $("#onSearchBtn").click(function(){
            $("#grid").coGrid("load",{
                url  : "${pageContext.request.contextPath}/search/searchStudentIssueList.ajax",
                form : "#searchFrm"
                });
            return false;
        });
        
        //Default 조회일자
        $.coUtils.datepicker( "#p_sdate" );
        $.coUtils.datepicker( "#p_edate" );
        
        /*
        $("#grid").ajaxStart(function() {
            $(this).block({ 
                message: 'Loading...' 
            }); 
        }).ajaxStop(function() {
            $(this).unblock();
        });
        */

        //팝업닫기
        $("#onPopupCloseBtn").click(function() {
            $("#popup_detail_dialog").dialog("close");
            return false;
        });
        
    });
    
    function showDetailDialog(idno) {
        $.coAjax({
            url     : contextPath + "/search/shwoDetailInfo.ajax",
            data    : "bas_idno=" + idno,
            success : function (data, textStatus, jqXHR) {
                var detail = data.detail;
                $("#dtl_name").val(detail.bas_name);
                $("#dtl_psnm").val(detail.bas_psnm);
                $("#dtl_poto").attr("src", "${pageContext.request.contextPath}/common/getImage.do?pot_idno="+detail.bas_idno);

                $("#popup_detail_dialog").dialog({ 
                    modal: false
                    ,width : 650
                });
                
            }
        });   
    }

    </script>
    
</head>
<body>

<button id="onSearchBtn">조회</button>

    <form action="" method="post" id='searchFrm' name='searchFrm'>
        <table border=1px>
            <colgroup>
                <col width="30%" />
                <col width="70%" />
            </colgroup>
            <tr>
                <th>발급일자</th>
                <td><input class="w80" type="text" id="p_sdate" name="p_sdate" readonly value="" />&nbsp;~&nbsp;<input class="w80" type="text" id="p_edate" name="p_edate" readonly value="" /></td>
            </tr>
            <tr>                
                <th>발급장소</th>
                <td><%=CodeSelect.makeCodeSelect("p_isdi", "전체", "his_isdi", "", "") %></td>
            </tr>        
            <tr>                    
                <th>신분구분</th>
                <td><%=CodeSelect.makeCodeSelect("p_iddi", "전체", "bas_iddi", "", "1") %></td>
            </tr>        
            <tr>                    
                <th>재적상태</th>
                <td><%=CodeSelect.makeCodeSelect("p_sdco", "전체", "bas_sdco", "", "") %></td>
            </tr>
            <tr>
                <th>학과</th>
                <td><input class="w80" type="text" id="p_psnm" name="p_psnm" /></td>
            </tr>        
            <tr>                    
                <th>학번</th>
                <td><input class="w80" type="text" id="p_idno" name="p_idno" /></td>
            </tr>        
            <tr>                    
                <th>성명</th>
                <td><input class="w80" type="text" id="p_name" name="p_name" /></td>
            </tr>        
            <tr>                    
                <th>수수료</th>
                <td><select id="p_iscg" name="p_iscg" >
                        <option value=''>전체</option>
                        <option value='1'>유료</option>
                        <option value='2'>무료</option>
                    </select></td>
            </tr>
            <tr>                    
                <th>발급사유</th>
                <td><%=CodeSelect.makeCodeSelect("p_rsco", "전체", "his_rsco", "", "") %></td>
            </tr>
            
        </table>
    </form>

    <div id="grid"></div>

<div style="display:none;">
    <div id="popup_detail_dialog" class="popupLayer" title="상세정보">
        <div class="popupContenet">
            <div class="popArea">
                <table border=0>
                    <colgroup>
                        <col width="30%" />
                        <col width="70%" />
                    </colgroup>
                    <tr>
                        <th>pot_poto</th>
                        <td><img id="dtl_poto" name="dtl_poto" width="104px" height="127px" src=""/></td>
                    </tr>
                    <tr>
                        <th>bas_name</th><td><input class="w80" type="text" id="dtl_name" name="dtl_name" /></td>
                    </tr>
                    <tr>
                        <th>bas_psnm</th><td><input class="w80" type="text" id="dtl_psnm" name="dtl_psnm" /></td>
                    </tr>
                </table>
            </div>
            <div align="center" class="srhBtn">
                <a href="#" id="onPhotoSaveBtn" class="btn"><span>저장</span></a>
            </div>
        </div>
        
        <!-- button area -->
        <div class="btnClose">
            <a id="onPopupCloseBtn"  href="#">닫기</a>
        </div>
    </div>
</div>
    
</body>
</html>
