<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import = "java.util.HashMap
            , java.util.List
            , java.util.ArrayList
            , com.cyberone.report.Constants
            , com.cyberone.report.utils.StringUtil"
%>

<%
List<HashMap<String, Object>> slctAssetList = (List<HashMap<String, Object>>)request.getAttribute("slctAssetList");
if (slctAssetList == null) {
	slctAssetList = new ArrayList<HashMap<String, Object>>();
}
String sReportType = (String)request.getParameter("reportType");
String sGroupCode = (String)request.getParameter("groupCode");
String sParentName = (String)request.getParameter("pGroup");
String sClientName = (String)request.getParameter("cGroup");
String sCiType = (String)request.getParameter("ciType");
String sCiText = (String)request.getParameter("ciText");
%>
<script type="text/javascript">

REPORT_OPTION = (function() {
	var _Dlg;
    var _formData = {};

    $("#rptopt_sPeriod").datetimepicker({
        showHour: false,
        showMinute: false,
        showSecond: false,
        showTime: false,
        dateFormat: 'yy-mm-dd',
        timeFormat: ''
    });
    
	$("#accordion").accordion({ 
		active: false,
		header: "> div > h3",
		heightStyle: "content",
		collapsible: true,
		animate: 300,
		activate: function( event, ui ) {
			try {
			    _formData[ui.oldHeader.attr("assetCode")] = FORM_OPTION.done();
			} catch(e) {}
			
			ui.oldPanel.children().remove();
			ui.newPanel.load("/product/formUI?option=" + ui.newHeader.attr("reportType") + "_" + ui.newHeader.attr("prefix") , function() {

				if (ui.newHeader.attr("prefix") == "servicedesk") {
					if (!_formData[ui.newHeader.attr("assetCode")]) {
                        $.ajax({
                            url : "/product/assetFormInfo",
                            type : 'POST',
                            data : {
                                  "prefix": ui.newHeader.attr("prefix").toLowerCase(), 
                                  "reportType": ui.newHeader.attr("reportType"), 
                                  "assetCode": ui.newHeader.attr("assetCode")
                            },
                            dataType: 'json',
                            success : function(data){
                            	_formData[ui.newHeader.attr("assetCode")] = { "data" : data.formMap };
                            	FORM_OPTION.init(_formData[ui.newHeader.attr("assetCode")],  data.formInfo, ui.newHeader.attr("assetCode"));
                            }
                        });
					}
				} else {
					
					$.ajax({
	                    url : "/product/assetFormInfo",
	                    type : 'POST',
	                    data : {
	                    	  "prefix": ui.newHeader.attr("prefix").toLowerCase(), 
	                    	  "reportType": ui.newHeader.attr("reportType"), 
	                    	  "assetCode": ui.newHeader.attr("assetCode")
	                    },
	                    dataType: 'json',
	                    success : function(data){
	                    	if (!_formData[ui.newHeader.attr("assetCode")]) {        	
	                    		_formData[ui.newHeader.attr("assetCode")] = { "data" : data.formMap };
	                    	}
	                    	FORM_OPTION.init(_formData[ui.newHeader.attr("assetCode")],  data.formInfo, ui.newHeader.attr("assetCode"));
	                    }
	                });
						
				}				
			});
		}
	})
	.sortable({
        axis: "y",
        handle: "h3",
        items: ".Group",
        cancel: ".DontMove",
        stop: function( event, ui ) {
          // IE doesn't register the blur when sorting
          // so trigger focusout handlers to remove .ui-state-focus
          ui.item.children( "h3" ).triggerHandler( "focusout" );
          // Refresh accordion to handle new order
          //$( this ).accordion( "refresh" );
        }
    });
	
	$("#rptopt_chk_review").change(function() {
	    if ($("#rptopt_chk_review").is(":checked")) {
	    	$("#rptopt_review_tr").show();
	    } else {
	    	$("#rptopt_review_tr").hide();
	    }	
	});
	
    return {
        init : function(Dlg) {
        	_Dlg = Dlg;
            
            _Dlg.dialog({
                autoOpen: false,
                resizable: false,
                width: 1050, 
                height: 700, 
                modal: true,
                title: "보고서출력",
                buttons: {
                    "보고서출력": function() {
                    	console.log(_formData);
                    	
                        var printOption = {};
                        printOption["reportType"] = "<%=sReportType%>";
                       
                                            	
                    	var formDatas = [];
                    	$.each($("#accordion").find("h3"), function(idx, temp) {
                    		console.log($(temp).attr("assetCode"));
                    		var param = {"assetCode": $(temp).attr("assetCode"), "prefix": $(temp).attr("prefix"), "formData": _formData[$(temp).attr("assetCode")]}
                    		formDatas.push(param);
                    	});
                    	
                    	console.log(formDatas);

                    	printOption["formDatas"] = formDatas;
                    	
                    	console.log(printOption);
                    	stop();
                        $.ajax({
                            url : "/report/printReport",
                            type : 'POST',
                            data : { printOption : JSON.stringify(printOption) },
                            dataType: 'json',
                            success : function(data){
                                if (data.status == 'success') {
                                } else {
                                }
                            }
                        });
                    	
                    },
                    "취소": function() {
                        _Dlg.dialog("close");
                    }
                },
                close: function( event, ui ) {
                    _Dlg.parent().remove();
                    _Dlg.children().remove();
                },
                open: function( event, ui ) {
                    $('.ui-dialog-buttonpane').find('button:contains("보고서출력")').button({icons: { primary: 'ui-icon-check' }});
                    $('.ui-dialog-buttonpane').find('button:contains("취소")').button({icons: { primary: 'ui-icon-closethick' }});
                }            
            });
            _Dlg.dialog("open");    
            _Dlg.dialog('option', 'position', 'center');                
        }
    };
})();

$(document).ready(function () {
}); 

</script>

        <div class="dialog_Body" style="width: 485px;height: 580px;float: left;overflow-x: hidden;overflow-y: auto;">
            <div style="width:100%;padding-bottom:10px;">
                <h7 style="margin-bottom: 5px;padding-top: 10px;color: #386abb;font-weight: bold;font-size: 16px;"><%=Constants.getReportTypeName(sReportType) %></h7>
                <h8 style="margin-bottom: 5px;padding-top: 10px;color: #747474;font-weight: bold;font-size: 14px;">ㅣ <span id="rptopt_group"><%=sParentName %></span>&nbsp;&gt;&nbsp;<span id="rptopt_client"><%=sClientName %></span></h8>
            </div>
            <div class="rptOptInfo">
            <table width="100%" cellspacing="0" cellpadding="0" summary="보고서리스트">
                <colgroup>
                   <col width="80" />
                   <col width="50" />
                   <col width="70" />
                   <col width="*" />
                </colgroup>
                <tr>
                    <th>보고서제목</th>
                    <td colspan="3">
                <% if (sCiType.equals("text")) { %>
                        <%=StringUtil.convertString(sCiText) %>
                <% } else { %>
                        <img src="imageDownload?type=report&code=<%=sGroupCode%>&pos=ci">
                <% } %>
                    </td>
                </tr>
                <tr>
                    <th>보고유형</th>
                    <td colspan="3">
                        <input id="rptopt_lb13" name="rptopt_rptSct" type="radio" class="chk_rdo_none" checked/><label for="rptopt_lb13">관제실적+원시로그통계</label>
                        <input id="rptopt_lb14" name="rptopt_rptSct" type="radio" class="chk_rdo_none" /><label for="rptopt_lb14">관제실적</label>
                        <input id="rptopt_lb15" name="rptopt_rptSct" type="radio" class="chk_rdo_none" /><label for="rptopt_lb15">원시로그 통계</label>
                    </td>
                </tr>
                <tr>
                    <th>조회기간</th>
                    <td colspan="3">
                <% if (sReportType.equals("1")) { %>
                        <input type="text" name="timepicker" id="rptopt_sPeriod" value="" class="datetime">&nbsp;&nbsp;&nbsp;&nbsp;
                <% } else if (sReportType.equals("2")) { %>
                <% } else if (sReportType.equals("3")) { %>
                        <select id="rptopt_search_period">
                            <option>2013-12</option>
                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                <% } else if (sReportType.equals("4")) { %>
                <% } %>
                    </td>
                </tr>
                <tr>
                    <th>총평쓰기</th>
                    <td colspan="3"><p><input id="rptopt_chk_review" type="checkbox" class="chkbox" checked/></p></td>
                </tr>
                <tr id="rptopt_review_tr">
                    <th>총평</th>
                    <td colspan="3">
                        <textarea id="rptopt_review" style="width:95%;height:100px"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>출력포맷</th>
                    <td colspan="3">
                        <input id="rptopt_lb11" name="rptopt_format_radio" type="radio" class="chk_rdo_none" value="docx" checked/><img class="checkFormat" src="/img/icon_word.png" alt="워드아이콘" width="16" height="16" /><label for="rptopt_lb11">MS WORD</label> 
                        <input id="rptopt_lb12" name="rptopt_format_radio" type="radio" class="chk_rdo_none" value="pdf" /><img class="checkFormat" src="/img/icon_pdf.png" width="16" height="16" /><label for="rptopt_lb12">PDF</label>
                    </td>
                </tr>
            </table>
            </div>
        </div>

        <div id="control01_dialogAddChart_content"  class="dialog_Body" style="width: 490px;height: 580px;float: left;overflow-y: scroll;margin-left: 10px;">
        
		<div id="accordion">
            <div class="DontMove">
	            <h3 reportType="<%=sReportType %>" prefix="servicedesk" assetCode="<%=sGroupCode%>">서비스데스크</h3>
	            <div>
	            </div>
		    </div>
		<% for (HashMap<String, Object> hMap : slctAssetList) { %>
		    <div class="Group">
				<h3 reportType="<%=sReportType %>" prefix="<%=StringUtil.convertString(hMap.get("prefix")).toLowerCase() %>" assetCode="<%=StringUtil.convertString(hMap.get("id"))%>">
	                <%=StringUtil.convertString(hMap.get("name")) %>
	                <div style="float:right;"><%=StringUtil.convertString(hMap.get("assetType")) %></div>
	                <div style="float:right;width:80px;"><%=StringUtil.convertString(hMap.get("prefix")) %></div>
	            </h3>
    			<div>
	       		</div>
			</div>
		<% } %>
		
		</div>

        
        
        
        </div>
            