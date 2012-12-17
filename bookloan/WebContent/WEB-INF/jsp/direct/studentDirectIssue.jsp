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
        순번, 발급일자, 발급차수, 바코드, 발급사유, 수수료, 발급장소, 처리자, 카드종류, 비고
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

<form action="${pageContext.request.contextPath}/issue/searchStaffInfo.do" method="post" id='searchFrm' name='searchFrm'>
    <input type="hidden" id="photo_flag" name="photo_flag" value="insa" />
    <table border=1>
        <colgroup>
            <col width="22%" />
            <col width="9%" />
            <col width="18%" />
            <col width="17%" />
            <col width="12%" />
            <col width="22%" />
        </colgroup>
        <tr>
            <td rowspan="9" align="center">
                <table border=1>
                    <tr><td><img src="${pageContext.request.contextPath}/images/snu_logo.png" alt="snu_logo"/></td></tr>
                    <tr><td><img width="104px" height="127px" src="${pageContext.request.contextPath}/common/getImage.do?m_no=${info.m_no}&photo_flag=${photo_flag}"/></td></tr>
                    <tr>
                        <td class="group">
                            <input type="hidden" id="h_dp_code" name="h_dp_code" value="${info.m_department}" />
                            <input class="group" type="text" id="h_department" name="h_department" value="${info.issue_department}" />
                       </td>
                    </tr>
                    <tr>
                       <td class="group_en">
                           <input type="hidden" id="h_hspt_code" name="h_hspt_code" value="${info.dp_hospital}" />
                           <input class="group_en" type="text" id="h_department_en" name="h_department_en" value="${info.dp_e_name}" style="ime-mode:disabled;"/>
                       </td>
                    </tr>
                    <tr>
                       <td class="name">
                           <input type="hidden" id="h_grp_code" name="h_grp_code" value="${info.m_group}" />
                           <input class="name" type="text" id="h_m_name" name="h_m_name" value="${info.m_name}" />
                       </td>
                    </tr>
                    <tr>
                       <td class="name_en">
                           <input type="hidden" id="h_phone" name="h_phone" value="${info.m_phone}" />
                           <input class="name_en" type="text" id="h_m_name_en" name="h_m_name_en" value="${info.issue_m_name_en}" style="ime-mode:disabled;"/>,&nbsp;
                           <input class="work" type="text" id="h_group_en" name="h_group_en" value="${info.issue_group_en}" style="ime-mode:disabled;"/>
                       </td>
                    </tr>
                </table>
            </td>
            <th>카드종류</th>
            <td><select id="slct_card_type" name="slct_card_type">
                    <option value='' >카드를 선택하세요.</option>
                    <option value='1' >PVC</option>
                    <option value='2' >IC</option>
                    <option value='3' >RF</option>
                    <option value='4' >스티커</option>
                </select></td>            
            <td colspan="2" style="display:none;">
                <input type="checkbox" id="mapping_check" name="mapping_check" /><span style="font-size:12px; font-weight:bold; color:red">RF재매핑 처리만 할 경우 체크해 주세요.</span>
            </td>
            <td colspan="3">a</td>
        </tr>
        <tr>
            <th>직원번호</th>
            <td><input class="w160" type="text" id="p_m_no" name="p_m_no" value="${info.m_no}" style="ime-mode:disabled;"/></td>
            <td><a href="#"  id="onSearchBtn" class="srhBtn"><span>조회</span></a></td>
            <th>기존발급일자</th>
            <td><input class="w160 r" type="text" value="${info.issue_date}" readonly/></td>
        </tr>
        <tr>
        <!-- 
            <th>주민번호</th>
            <td><input class="w160" type="password" id="p_m_regno" name="p_m_regno" value="${info.m_regno}" /></td>
        -->
            <th>직원명</th>
            <td><input class="w160" type="text" id="p_m_name" name="p_m_name" value="${info.m_name}" /></td>
            <td><a href="#"  id="onIssueBtn" class="srhBtn"><span>즉시발급</span></a></td>
            <th>기존발급차수</th>
            <td><input class="w52 r" type="text" value="<c:if test="${lastIssueCount > 0}">${lastIssueCount}</c:if>" readonly/></td>
        </tr>
        <tr>
            <th>영문직원명</th>
            <td><input class="w160 r" type="text" value="${info.m_e_name}" readonly/></td>
            <td></td>
            <th>기존카드종류</th>
            <td><input class="w52 r" type="text" value="${info.issue_card_type}" readonly/></td>
        </tr>
        <tr>
            <th>병원구분</th>
            <td><input class="w160 r" type="text" value="${info.hospital}" readonly/></td>
            <td></td>
            <th>기존카드상태</th>
            <td><input class="w52 r" type="text" value="${info.issue_status}" readonly/></td>
        </tr>
        <tr>
            <th>소속부서명</th>
            <td colspan="2"><input class="w200 r" type="text" value="${info.dp_name}" readonly/></td>
            <th>기존카드번호</th>
            <td><input class="w160 r" type="text" value="${info.issue_sno}" readonly/></td>
        </tr>
        <tr>
            <th>근무부서명</th>
            <td colspan="2"><input class="w200 r" type="text" value="${info.m_place_name}" readonly/></td>
            <th>재직상태</th>
            <td><input class="w52 r" type="text" value="${info.m_status}" readonly/></td>
        </tr>
        <tr>
            <th>영문부서명</th>
            <td colspan="2"><input class="w280 r" type="text" value="${info.dp_e_name}" readonly/></td>
            <th>발급일자</th>
            <td><input class="w160 r" type="text" value="${info.today}" readonly/></td>
        </tr>
        <tr>
            <th>직책명</th>
            <td><input class="w160" id="p_duty_name" name="p_duty_name" type="text" value="${info.m_duty_name}" readonly/></td>
            <td></td>
            <th>발급차수</th>
            <td><input type="text" class="w52 r" id="h_issue_count" name="h_issue_count" value="<c:if test="${info.m_no!=null}">${lastIssueCount}</c:if>" readonly/></td>
        </tr>
        <tr>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"  id="onCaptureBtn" class="srhBtn"><span>사진캡쳐</span></a>&nbsp;<a href="#"  id="onFileBtn" class="srhBtn"><span>사진찾기</span></a></td>
            <th>직종명</th>
            <td><input class="w160 r" type="text" value="${info.m_group_name}" readonly/></td>
            <td></td>
            <th>SMS 전송여부</th>
            <td><select id="slct_sms_yn" name="slct_sms_yn" <c:if test="${info.m_phone=='' || info.m_phone==null}">disabled</c:if>>
                    <option value='Y'>SMS전송</option>
                    <option value='N' selected>SMS미전송</option>
                </select>&nbsp;&nbsp;<input type="text" class="w90 r" id="phone_no" name="phone_no" value="${info.m_phone}" readonly/></td>
        </tr>
        
    </table>
</form>    

<div id="grid"></div>
    
</body>
</html>
