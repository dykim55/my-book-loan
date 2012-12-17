
	/**
	*****************************  그리드 생성 ***************************
	- groupHead : 그룹할 내용 기술 (타입 : {})
		- name : 화면에 보여줄 그룹명
		- startId : 그룹핑 시작할 ID.
		- colspan : colspan.
	- head : 헤더 정보 기술 (타입 : {})
		- id : 키가되는  ID
		- Name : 화면에 보여줄 이름
		- width : 넓이
		- edit : 에디터 모드 가능여부(추가시 만 설정)
			- 데이터 : true | false
		- type : 해당 컬럼 데이터의 타입
			- status : 해당 Row의 상태를 표시(statusData으로 설정)
			- select : 셀렉트 박스
			- check : check 박스
			- text : text 박스
			- button : 버튼
			- hidden : 데이터를 숨김
			
		- selector : 셀렉트 박스 설정
			- 구조 : [ [ name_1, name_2, name_n ], [ value_1, value_2, value_n ] ]
		- checker : check 박스  설정
			- 구조 : {defaultVal:(true|false), ok:"체크시 화면에 보여줄 문자열",no:"미체크시 화면에 보여줄 문자열"}}
			- defaultVal : 기본 값설정
		- btnName : 타입이 button시 보여줄 버튼 명
		- click : 타입이 button일때 클릭이벤트 
		- width : 넓이를 설정
			- width : 50
		- className : 클래스를 설정
			- className : "testClass"
			- className : ["tcl1", "tcl2"]
		- formatter : 데이터를 정제하여 화면에 출력
			- function(rowNo,colId,data,rowdate)
		- updatemode : 업데이트 가능여부 ( 기본값 :  true)
			- true | false
		- editBoxStyle : 데이터 모드시 넣을 스타일
			- "width:100px;"
		- hiddenCol : 사용자 히든 설정 컬럼(디폴트는 false) 
			- true:false
		- hidden : hiddenCol 설정시 히든 초기값 (true|false)
		- editComplete : 에디터 모드로 변환시 호출 ( jQuery 형태의 Element를 리턴해야 함)
			- editComplete : function (status, rowNo, head, input, data){ return input;}
		- title : 해당 컬럼에대한 설명, 해당내용은 마우스를 컬럼에 대면 나타난다.(hidden 시 컬럼명 확인)
	- width : 그리드 넓이 
	- rowNum : 보여줄 총  Row 갯수( 값 : 숫자형 )
	- rowCount : 그리드에 자동 시퀀스 여부 (true|false)
	- paging : 페이징 기능 사용여부 (true|false)
	- scrollbar : 스크롤바 여부
	- scrollbarWidth : 가로 스크롤바 여부
	- scrollbarHeight : 세로 스크롤바 여부
	- statusData : 화면에 보여줄 Status 데이터 편집
		- 데이터 : {U:"설정값",D:"설정값",I:"설정값"}
	- complete : 설정이 끝난후 실행할 평션
		- 데이터 : function
		- 예)	complete : function (grid){
						grid.coGrid("load")
					}
	*****************************  메소드  ***************************
	
	- load	
		설명: 그리드데이터를 불러옴
		파라미터:
			{ 
				url : "URL"
				[,data:"dataName1=data&dataName2=data&" ]
				[,form: "tagetForm" ]
				[,complete: function ]
			}
		예)
			.coGrid("load",
				{
				url:"URL"
				,data:"dataName1=data&dataName2=data&"
				,form : "tagetForm"
				,complete: function (data, grid){
					}
				})
	
	- modify
		설명 : row를 수정 모드로 변환
		파라미터1 : 수정모드로 변환할 ROWNO
		[complete] : 수정하고 실행할 function
		예) .coGrid("modify","1" , function(tr_ele){
			alert(tr_ele);
		});
	
	- new
		설명 :신규 ROW 추가
		[파라미터]: 생성후 해당 ROWNO 에대한 처리
		예 ) $("#grid").coGrid("new",function(rowNo , tr_ele){
					$.coUtils.chengeModify("#grid", "D",rowNo);
					return false;
			});
	
	- resetRow
		설명 : 해당 row를 원복
		파라미터 : 해당 rowNo
		예) .coGrid("resetRow","1")
	
	- deleteRows
		설명 : 해당 row들을 삭제표시
		파라미터 : rowNo이 들어간 Array
		예) .coGrid("deleteRows",["1","2"]) //rowNo이 1,2번인 ROW를 삭제표시
	
	- getCheckRow
		설명 : 선택한 ROWNO을 리턴
		파라미터 : 없음
		예 ) .coGrid("getCheckRow") ; //선택한  ROWNO목록([1,2,3])이 리턴
	
	- setCheckRow
		설명 : 체크 박스를 셋팅
		파라미터1 : rowNo or array(rowNo)
		[파라미터2] : true|false //디폴트는 true
		예1 ) .coGrid("setCheckRow",1) ; 
		예2 ) .coGrid("setCheckRow",['1','2'],false) ; 
		예3 ) .coGrid("setCheckRow") ; //모두 선택 
	
	- saveRowData
		설명 : 변경된 항목(status를 이용)의 데이터를 R리턴
		파라미터 : 변경사항 체크
		예 ) .coGrid("saveRowData") //Object( ={} )데이터로 변환
		예 ) .coGrid("saveRowData",false) // 변경사항 체크하지 않음.(메세지 않나옴.)
	
	- reLoad
		설명 : Grid데이터를 재조회
		파라미터 : 없음
		예 ) .coGrid("reLoad")
	
	- getRowData
		설명 : 파라미터의 데이터를 가져온다.
		파라미터 : rowNo or array(rowNo)
		예 ) 	.coGrid("getRowData",1)
			.coGrid("getRowData",[1,2])
			결과
			 파라미터가 String일경우 :
			 	{ headId:value } 형식으로 리턴
			 파라미터가 String이 아닌경우 :
			 	{rowNo: { headId:value } } 형식으로 리턴
	
	- insert
		설명 : 데이터 한줄을 추가한다,(new는 빈줄) Status는 Insert로 삽입
		파라미터1 : Row데이터({name:value})
		[파라미터2] : 추가후 실행할 function
		[파라미터3] : 삽입 위치 (first|last) 기본은 first
		예 ) 	.coGrid("insert",{h1:"data",h2:"data"},function(rowNo){alert(rowNo);})
	
	- remove
		설명 : 해당 ROW들을 삭제(완전삭제)
		파라미터 : rowNo or array(rowNo)
		예 ) 	.coGrid("remove",1)
			.coGrid("remove",[1,2])
	
	- highlight
		설명 : 해당 Row 하이라이트
		파라미터 : rowNo, [true|false]
		예) .coGrid("highlight",'1'); //하이라이트
		 	.coGrid("highlight",'1',false); //하이라이트 취소
	- getHighlightRowNos
		설명 : 하이라이트 항목의 RowNo를 가져오기
		예)vat data = [];
		 	data = $(?).coGrid("getHighlightRowNos"); //하이라이트 rowNo 목록
	- setCol
		설명 : 해당 데이터를 셋팅
		파라미터	: rowNo , colId , data
		예) .coGrid("setCol", "1", "id", "data");
		
	- getCol
		설명 : 해당 데이터를 가져옴
		파라미터	: rowNo , colId 
		예) data = $(?).coGrid("getCol", "1", "id");
	- clean
		설명 : 그리드를 초기화(내용 모두 삭제)
	- unCheck
		설명 : 그리드의 모든 체크박스를 취소한다.
	- getColElement
	    설명 : 그리드의 해당 Element를 가져온다. Edit일경우 Element 리턴, Text일경우 Text리턴
	     .coGrid("getColElement", "1", "id");
	- rowLength
		설명 : row갯수를 가져온다
	*****************************  유틸  ***************************
	$.coAjax({url:value,data:param})
		설명 : Ajax기능의 디폴트를 자동 설정
		예) $.coAjax({
				url : url
				,success : function(data, textStatus, jqXHR){
					
				}
			});
		
	$.coUtils.listToParam(data,[데이터체크])
		설명 : 데이터를 파라미터로(URLEncoding)변환
		예 ) 
			param = $.coUtils.listToParam(
					saveData,
					{
						sc_name : 
							function( data, colName, rowName){
								if($.coUtils.isEmpty(data)){
									alert("스케줄명은 필수 사항입니다.");
									return false;
								}else return true;
							}
					});
					
	$.coUtils.chengeModify : function (selector,tag,rowNo)
		설명: 수정버튼의 기능을 자동으로 변환( 수정 - > 취소 )
	
	$.coUtils.isEmpty(data)
		설명 : (data == undefined || data == null || "" == data);
					
	$.coUtils.textToHtml(data)
		설명 : , > < " 코드를 HTML 코드로 변환
	$.coUtils.datepicker(selector , [option])
		설명 : 달력레이어를 설정
		예 1 ) $.coUtils.datepicker( "#trn_start_dt" );
		예 2 ) $.coUtils.datepicker( 
				$("td[colId|='hd_date'] > input" ,tr_ele),
				{dateFormat : "mmdd", buttonText : undefined, showOn : undefined}
			);		
	$.coUtils.arrayAdd(array,val)
		설명 : Array 마지막에 데이터 넣기
	*/

jQuery.coAjax = function(param){
	
	defualt = {
		dataType:"json",
		contentType:'application/x-www-form-urlencoded; charset=utf-8',
		type:'POST',
		error:function(a,b,c){
			if(a.status){
				if(a.status == '404'){
					alert("해당 URL("+c+")페이지가 없습니다.");
				}else if(a.status == '500'){
					alert("에러가 발생하였습니다. 관리자에게 문의해 주시기 바랍니다.");
				}
			}else{
				alert(a+":"+b);
			}
			
		}
//		,complete : function() { alert("complete"); }

	};
	for ( var ele in defualt) {
		if(param[ele] == undefined)param[ele] = defualt[ele];
	}
	param.ok = param.success;
	param.success = function(data, textStatus, jqXHR){
		
		if(data && data.status == "error"){
			if(data.type == 'login'){
				
				alert("로그인정보가 없습니다. 로그인 페이지로 이동합니다.");
				location.href = contextPath+"/login/loginView.do";
			}
			
		}else if(data && data.status == "exception"){
			
			alert("에러가 발생 하였습니다. \n\n[" + data.msg + "]");
			return ;
		}else{
			if($.type(data) === 'string'){
				try{
					var json_data = eval("("+data+")");
					if(data.status == "error" && json_data.type == 'login'){
						
						alert("로그인정보가 없습니다. 로그인 페이지로 이동합니다.");
						location.href = contextPath+"/login/loginView.do";
						return;
					}
				}catch(e){
				}
			}
			
			if(this.ok)this.ok(data, textStatus, jqXHR);
		}
	};
	$.ajax(param);
};
jQuery.fn.coDialog = function(tag, param , param2, param3) {
	var t = this;
	if(typeof(tag) == 'object'){
		var alphaLayer = $(".coAlphaLayer");
		if(alphaLayer.length == 0){
			alphaLayer = $('<div></div>').prependTo($("body"));
			alphaLayer.addClass("coAlphaLayer");
		}
		alphaLayer.css("display","");
		
		t.addClass("coDialog");
		
		t.css("display","");
	}else if("close" == tag){
		var alphaLayer = $(".coAlphaLayer");
		alphaLayer.css("display","none");
		t.css("display","none");
	}
	
	//width
	//coDialog
	
};

jQuery.fn.coGrid = function(tag, param , param2, param3) {
	try{
	
	var t = this;
	if(typeof(tag) == 'object'){
		return t.each(function(){
			var tt =  this;
			var jtt =  $(this);
			if(!tag.statusData){
				tag.statusData = { I : "I" , U : "U" , D : "D" };
			}
			tt.grid = tag;
			tt.grid.newRowCount = 0;
			h = tag.head;
			gh = tag.groupHead;
			jtt.addClass("root_grid");
			tt.grid.head_id = {};
			var chkEditBoxStyleFun = function(style){
				
				if(style){
					if(style.indexOf("width:") == -1){
						style += "width:85%;";
					}
					style = "style='" + style + "'";
				}else{
					style = "style='width:85%;'";
				}
				return style;
			};
			
			
			//셀렉트박스 기본데이터 셋팅
			for(var i = 0 ; i < h.length;i++){
				type = h[i].type;
				
				if(type == 'select'){
					selector = h[i].selector;
					key = selector[0];
					value = selector[1];
					
					tempHtml = "<select name='"+ h[i].id + "' ";
					tempHtml += chkEditBoxStyleFun(h[i].editBoxStyle) +  ">";
					
					selectValMap = {};
					selectKeyMap = {};
					for ( var j = 0; j < key.length; j++) {
						tempHtml += '<option value="'+value[j]+'">'+key[j]+'</option>';
						selectValMap[value[j]] = key[j];
						selectKeyMap[key[j]] = value[j];
					}
					
					tempHtml += "</select>";
					h[i].tempHtml = tempHtml;
					h[i].selectValMap = selectValMap;
					h[i].selectKeyMap = selectKeyMap;
					
				}else if(type == 'text'){
					tempHtml = "<input type='text' name='"+ h[i].id + "' ";
					tempHtml += chkEditBoxStyleFun(h[i].editBoxStyle) +  "/>";
					h[i].tempHtml = tempHtml;
				}else if(type == 'check'){
					tempHtml = "<input type='checkbox' name='"+ h[i].id + "' ";
					tempHtml += chkEditBoxStyleFun(h[i].editBoxStyle) +  "/>" ;
					h[i].tempHtml = tempHtml;
				}
				
				tt.grid.head_id[h[i].id] = h[i];
			}
			
			var ha = [];
			var colgroup = "";
			
			if(tag.rowCount){ 
				ha[ha.length] = {html:"순번",  style : {}};
				colgroup += "<col width='50' />";
			}
			if(tag.checkbox){ 
				ha[ha.length] = {html: "<input type='checkbox' class='allcheck'>", style : { }};
				colgroup += "<col width='40' />";
			}
			
			for(var i = 0 ; i < h.length ; i++){
				if( h[i].type == "hidden" ) continue;
				
				html =  h[i].name;
				title = ( h[i].title ? h[i].title : h[i].name);
				if(h[i].hiddenCol){
					html += ' <a href="javascript:$.coGridUtils.hiddenCol(true,\''+tt.id+'\',\''+h[i].id+'\',\''+h[i].name+'\',this);"  class="button"><span>-</span></a>';
				}
				ha[ha.length] = {id: h[i].id , html:html, title :title , style : { hidden: false}, className : h[i].className };
				colgroup += "<col propName='" + h[i].id + "'";
				if( h[i].width){
					colgroup += " width='" +h[i].width+ "'";
				}
				colgroup += "/>";
			}
			for(var i = 0 ; i < h.length ; i++){
				html =  h[i].name;
				
				if( h[i].type != "hidden" ) continue;
				
				ha[ha.length] = {id: h[i].id , html:html, title : "", style : { hidden: true} };
				colgroup += "<col propName='" + h[i].id + "'  style='width:0px;' />";
			}
			
			if(gh){
				var p = 0;
				bgh = [];
				bgh2 = [];
				for(var i = 0 ; i < ha.length ; i++){
					ins = bgh.length;
					if(gh[p] && gh[p].startId == ha[i].id){
						bgh[ins] = { html: gh[p].name, colspan : gh[p].colspan};
						
						max = i + gh[p].colspan;
						for( ; i < max ; i++){
							bgh2[bgh2.length] = ha[i];
						}
						i--;
						p++;
					}else{
						bgh[ins] = ha[i];
						bgh[ins].rowspan = 2;
					}
				}
				ha = [bgh,bgh2];
			}else{
				ha = [ha];
			}
			head = "";
			
			for(var j = 0 ; j < ha.length ; j++){
				ghd = ha[j];
				head += "<tr>";
				for(var i = 0 ; i < ghd.length ; i++){
					head += "<th title='" +  ( ghd[i].title ?  ghd[i].title : "" ) + "'";
					if(ghd[i].id){
						head += " h_col='" + ghd[i].id +"'";
					}
					if(ghd[i].style){
						style = ghd[i].style;
						head += " style='";
						if(style.hidden){
							head += "display:none;";
						}
						head += "'";
					}
					
					
					if(ghd[i].rowspan != undefined){
						head += " rowspan='" + ghd[i].rowspan + "'";
					}
					if(ghd[i].colspan != undefined){
						head += " colspan='" + ghd[i].colspan + "'";
					}
					if(ghd[i].className != undefined){
						head += " class='";
						if($.isArray(ghd[i].className)){
							classNames = ghd[i].className;
							for ( var cn = 0; cn < classNames.length; cn++) {
								head += classNames[cn] + " ";
							}
						}else{
							head += ghd[i].className;
						}
						head += "'";
					}
					head += ">" + ghd[i].html;
					
					head += "</th>";
				}
				head += "</tr>";
			}
			
			
			colgroup = "<colgroup>" + colgroup + "</colgroup>";
			html = "<table border='1' style='width:100%;'>" + colgroup + "<thead>" + head +"</thead><tbody></tbody>";
			html += "<tfoot style='display:none;'><tr> <td>조회된 항목이 없습니다.</td></tr></tfoot></table>";
			html = "<div class='grid' >" + html + "</div>";
			
			jtt.html(html);
			
			if(tag.scrollbar){
				$(".grid",tt).css("overflow","auto");
				
				if(tag.width) $(".grid",jtt).css("width" , tag.width + "px");
				if(tag.height) $(".grid",tt).css("height",tag.height + "px");
				
			}else if(tag.scrollbarWidth){
				$(".grid",tt).css("overflow-x","auto");
				
				if(tag.width) $(".grid",jtt).css("width" , tag.width + "px");
				if(tag.height) $(".grid",tt).css("min-height",tag.height + "px");
				
			}else if(tag.scrollbarHeight){
				$(".grid",tt).css("overflow-y","auto");
				if(tag.width) $(".grid",jtt).css("width" , tag.width + "px");
				if(tag.height) $(".grid",tt).css("height",tag.height + "px");
				
			}else{
				if(tag.width) $(".grid",jtt).css("width" , tag.width + "px");
				if(tag.height) $(".grid",tt).css("min-height",tag.height + "px");
			}
			
			//페이징
			if(tt.grid.paging){
				pHtml = "<div class='page' align='center'>";
				pHtml += ' <a href="#" class="page_start"><img src="' + contextPath + '/images/btn_first.gif" alt="처음 페이지" /></a> ';
				pHtml += '  <a href="#" class="page_before"><img src="' + contextPath + '/images/btn_prev.gif" alt="이전 페이지" /></a>';
				pHtml += " <span> page <input class='page_input' type='text'> of <span class='maxpage'></span> </span>";
				pHtml += '  <a href="#" class="page_next"><img src="' + contextPath + '/images/btn_next.gif" alt="다음 페이지" /></a>';
				pHtml += '  <a href="#" class="page_end"><img src="' + contextPath + '/images/btn_end.gif" alt="마지막 페이지" /></a>';
				
				
//				pHtml += "  <button class='page_start'>처음 </button>";
//				pHtml += " <button class='page_before'>이전</button>";
//				pHtml += " <span> page <input class='page_input' style='ime-mode:disabled' type='text'> of <span class='maxpage'></span> </span>";
//				pHtml += " <button class='page_next'>다음</button>";
//				pHtml += " <button class='page_end'>마지막</button>";
				
				if($.isArray(tt.grid.rowNums) && tt.grid.rowNums.length > 0){
					tt.grid.rowNum =  tt.grid.rowNums[0];
					pHtml += "<select>";
					for ( var w = 0; w < tt.grid.rowNums.length; w++) {
						var a = tt.grid.rowNums[w];
						pHtml += "<option value='" + a + "'>" + a + "</option>";
					}
					pHtml += "</select>";
				}
				pHtml += "</div>";
				jtt.append(pHtml);
			}
			if($.isArray(tt.grid.rowNums) && tt.grid.rowNums.length > 0){
				$(".page select",t).change(function(){
					tt.grid.rowNum =  this.value;
					jtt.coGrid("reLoad");
					
				});
			}
			
			$(".allcheck", tt).click(function(){
				
				if(this.checked){
					$(".col_check",tt).attr("checked","checked");
				}else{
					$(".col_check",tt).removeAttr("checked");
				}
			});
			
			$('.page_input').keydown(function(event) {
				if(event.keyCode == 13){
					var P_grid = $(this).parents(".root_grid");
					var keyVal = eval(this.value);
					keyVal --;
					
					P_grid.each(function(){
						
						if(!this.grid.reload){
							alert("조회를 해주십시오.");
							return;
						}
						if(this.grid.loadData.maxPage < keyVal){
							alert("[" + (this.grid.loadData.maxPage + 1 ) + "]이하로 설정해 주십시오.");
							return;
						}else{
							this.grid.reload.page = keyVal;
							this.grid.searchMethod(this.grid.reload.url,this.grid.reload.param);
						}
					});
				}else if(8 != event.keyCode &&  46 != event.keyCode 
						&& !(47 < event.keyCode && event.keyCode < 58)){
					if(!(95 < event.keyCode && event.keyCode < 106)){
						event.preventDefault();
					}
				}
				
				
			});
			
			$(".page_start", tt).click(function(){
				 if(!tt.grid.reload)return;
				 if(tt.grid.reload.page > 0){
					 tt.grid.reload.page = 0;
					 tt.grid.searchMethod(tt.grid.reload.url, tt.grid.reload.param);
				 }
				return false;
			});
			$(".page_before", tt).click(function(){
				 if(!tt.grid.reload)return;
				 if(tt.grid.reload.page > 0){
					 tt.grid.reload.page--;
					 
					 tt.grid.searchMethod(tt.grid.reload.url,tt.grid.reload.param);
				 }
				return false;
			});
			$(".page_next", tt).click(function(){
				if(!tt.grid.reload)return;
				 if(tt.grid.reload.page < tt.grid.loadData.maxPage){
					 tt.grid.reload.page++;
					 tt.grid.searchMethod(tt.grid.reload.url,tt.grid.reload.param);
				 }
				return false;
			});
			$(".page_end", tt).click(function(){
				if(!tt.grid.reload)return;
				 if(tt.grid.reload.page < tt.grid.loadData.maxPage){
					 tt.grid.reload.page = tt.grid.loadData.maxPage;
					 tt.grid.searchMethod(tt.grid.reload.url,tt.grid.reload.param);
				 }
				return false;
			});
		 
			tt.grid.searchMethod = function (url , d){
				
				var data = "page=" + this.reload.page; 
				data += "&rowNum=" + this.rowNum;
				data += "&" + d;
				$("tfoot",jtt).css("display","none");
				$.coAjax({
					url:url,
					data:data,
					success : function (data, textStatus, jqXHR){
						jtt.each(function(){
							
							this.grid.newRowCount = 0;
							this.grid.loadData = data;
							var rowList = data.rowList;
							var head = this.grid.head;

							// 데이터 그리드에 반영
							var rowData = ""; 
							for ( var i = 0; i < rowList.length; i++) {
								rowData += "<tr rowNo='"+i+"'>";

								//No 가 있을경우
								if(this.grid.rowCount){ rowData += "<td>" + (eval(data.page) * eval(data.rowNum) + eval(i+1)) + "</td>"; }
								if(this.grid.checkbox){ rowData += "<td><input type='checkbox' class='col_check' rowNo='"+i+"'></td>"; }
								for ( var j = 0; j < head.length; j++) {
									
									if (head[j].type == "checkbox") {
										rowData += "<td colId='"+ head[j].id +"'>";
										rowData += "<input type='checkbox' rowNo='"+j+"' ";
										rowData += (rowList[i][head[j].id] == 'Y' ? "checked" : "") + "></td>"; 
									} else {
										rowData += "<td  colId='"+ head[j].id +"'";
										if(head[j].type == "hidden"){
											rowData += " style='display:none;'";
										}
										rowData += ">";
										
										if(!head[j].hidden){
											html = $.coGridUtils.tdCreate(head[j], rowList[i][head[j].id],i);
	//										html = $.coUtils.textToHtml(html);
											rowData += html;
										}
										rowData += "</td>";
									}
								}					
								rowData += "</tr>";
							}
							if(rowList == undefined || rowList.length == 0){
								var tds = $("thead tr:first th",this);
								var cnt = 0 ;
								for ( var i = 0; i < tds.length; i++) {
									if($(tds[i]).css("display") == 'none' ) continue;
									var colspan = eval($(tds[i]).attr("colspan"));
									if(!colspan || isNaN(colspan) || colspan < 2){
										cnt++;
									}else{
										cnt += colspan;
									}
								}
								
								$("tfoot tr td:last",this).attr("colspan",cnt);
								$("tfoot",this).css("display","");
							}
							//HTML 에 반영
							$("tbody",this).html(rowData);
							//그리드에 있는  버튼 설정
							for ( var j = 0; j < head.length; j++) {
								type = head[j].type;
								if(type == "button"){
									$.coGridUtils.tdCreate_button($("a[name|='"+ head[j].id+"']",this),head[j].click);
								}
							}
							//페이징 처리
							if(this.grid.paging){
								var page_div = $(t.selector + " .page");
								var totalCount = eval(this.grid.loadData.totalCount);
								var page = this.grid.loadData.page;
								this.grid.reload.page = page;

								maxPage = Math.floor( (( totalCount - 1 ) / this.grid.rowNum) );
								
								if(maxPage < 0){
									maxPage = 0;
								}
								this.grid.loadData.maxPage = maxPage;
								
								if(isNaN(maxPage)){
									maxPage = "";
								}else{
									maxPage++;
								}
								$(".maxpage",page_div).text(maxPage);
								$(".page_input",page_div).val((eval(page)+1));
							}
							if(this.grid.reload.complete && $.isFunction(this.grid.reload.complete)){
								
								this.grid.reload.complete(data,this);
							}
						});
					}
				});
			};
			
			for(var i = 0 ; i < h.length ; i++){
				if(h[i].hiddenCol && h[i].hidden){
					
					var buttion_thid = $(".grid thead th[h_col|='"+ h[i].id +"'] a",tt);
					buttion_thid.each(function(){
						$.coGridUtils.hiddenCol(true,tt.id,h[i].id,h[i].name,this);
					});
				}
			}
			
			
			if(tt.grid.complete){
				tt.grid.complete(jtt);
			}
			
			$("tbody",this).bind('mouseover',function(e) {
				var ptr = $(e.target).closest("tr");
				try{
				    if (ptr[0] != undefined && ptr[0].tagName == "TR") {
				    	ptr[0].bgColor="#c8f0ff";
			        }
				} catch(e) {return false;}
			});
			
			$("tbody",this).bind('mouseout',function(e) {
				var ptr = $(e.target).closest("tr");
				try{
				    if (ptr[0] != undefined && ptr[0].tagName == "TR") {
				    	ptr[0].bgColor="";
			        }
				} catch(e) {return false;}
			});			
			
			
		});
		
	}else if("load" == tag){
		t = t[0];
		$(".allcheck", t).removeAttr("checked");
		var data = ( param.data ? param.data : "");
		data += ( param.form ?  "&" + $(param.form).serialize() : "");
		if(!t.grid.reload )t.grid.reload = {};
		t.grid.reload.url = param.url;
		t.grid.reload.complete = param.complete;
		t.grid.reload.param = data;
		t.grid.reload.page = (param2?param2:0);
		
		t.grid.searchMethod(t.grid.reload.url, t.grid.reload.param);
		
	}else if("modify" == tag){
		var rowNo = param;
		var row = $("tr[rowNo|='" +rowNo+"']",this);
		t.each(function(){
			var head = this.grid.head;
			var rowData = this.grid.loadData.rowList[rowNo];
			
			for ( var i = 0; i < head.length; i++) {
				col = $("td[colId|='" +head[i].id+"']",row);
				if(!col)continue;
				if(head[i].edit == false)continue;
				if(head[i].updatemode == false)continue;
				
				colInput = null;
				type = head[i].type;
				
				if(type == "status"){
					colInput = this.grid.statusData.U;
				}else if(type == "button" || type == "hidden"){
					continue;
				}else{
					colInput = $(head[i].tempHtml);
					if(type == "text"){
						colInput.val(rowData[head[i].id]);
					}else if(type == "select"){
						colInput.val(rowData[head[i].id]);
					}else if(type == "check"){
						if( rowData[head[i].id] == "true" ){
							colInput.attr("checked", "checked");
						}else{
							colInput.removeAttr("checked");
						}
					}
					
					if($.isFunction(head[i].editComplete)){
						colInput = head[i].editComplete("U",rowNo, head[i] ,colInput, rowData[head[i].id]);
					}
					
				}
				if(colInput)col.html(colInput);
			}
			
			if($.isFunction(param2)){
				param2(this);
			}
		});
	}else if("new" == tag){
		t = t[0];
		
		$("tfoot",t).css("display","none");
		
		
		//$.coGridUtils.changeEditMode(row,t,rowNo,"I");
		
		
		var head = t.grid.head;
		
		var rowNo = t.grid.newRowCount++ ;
		
		var rowData = $("<tr rowNo='n_"+rowNo+"'></tr>");
		rowData.prependTo($("tbody",t));
		
		//No 가 있을경우
		if(t.grid.rowCount){ rowData.append("<td></td>"); }
		if(t.grid.checkbox){ rowData.append("<td><input type='checkbox' class='col_check' rowNo='n_"+rowNo+"'></td>"); }
		for ( var i = 0; i < head.length; i++) {
			type = head[i].type;
			
			colInput = null;
			var td = $("<td colId='"+ head[i].id +"'></td>").appendTo(rowData);
			
			if(head[i].edit == false){
				colInput = "";
			}else if(type == "status"){
				colInput = t.grid.statusData.I;
			}else if(type == "button"){
				colInput = $('<a href="#" name="'+ head[i].id +'" class="tblBtn button"><span>'+head[i].btnName +'</span></a>');
				colInput.click(function(){
					var rowNo = $(this).parents("tr").attr("rowNo");
					colId = $(this).parent().attr("colId");
					var click = t.grid.head_id[colId].click;
					return click(rowNo);
				});
			}else if(type == "hidden"){
				colInput = "";
				td.css("display","none");
			}else{
				if(type == "text"){
					colInput = $(head[i].tempHtml).val(rowData[head[i].id]);
				}else if(type == "select"){
					colInput = $(head[i].tempHtml).val(rowData[head[i].id]);
				}else if(type == "check"){
					colInput =  $(head[i].tempHtml);
					if(head[i].checker.defaultVal){
						colInput.attr("checked", "checked");
					}else{
						colInput.removeAttr("checked");
					}
				}
				if($.isFunction(head[i].editComplete)){
					colInput = head[i].editComplete("N", ( "n_" + rowNo), head[i], colInput, rowData[head[i].id]);
				}
			}
			td.append(colInput );
		}
		$("input[type|='text']", rowData).css("width","95%");
		$("input[type|='select']", rowData).css("width","95%");
		if($.isFunction(param)){
			return param("n_"+rowNo, rowData[0]);
		}
		
	}else if("resetRow" == tag){
		rowNo = param;
		t = t[0];
		
		rowData = "";
		
		var row = $("tbody tr[rowNo|='" +rowNo+"']",t);
		
		head = t.grid.head;
		rowList = t.grid.loadData.rowList;
			
		for ( var j = 0; j < head.length; j++) {
			
			var td = $("td[colId|='" +head[j].id+"']",row);
			tdHtml = $.coGridUtils.tdCreate(head[j], rowList[rowNo][head[j].id],rowNo);
			
			
			td.html(tdHtml);
			if(type == "button"){
				$.coGridUtils.tdCreate_button($("a",td),head[j].click);
			}
		}					
		
	}else if("deleteRows" == tag){
		t = t[0];
		var trs = $("tbody tr",t);
		head = t.grid.head;
		
		map = {};
		status = "";
		
		for ( var i = 0; i < head.length; i++) {
			if(head[i].type == "status"){
				status = head[i].id;
				break;
			}
		}
		
		for ( var i = 0; i < trs.length; i++) {
			map[trs[i].rowNo] = trs[i];
		}
		
		for ( var i = 0; i < param.length; i++) {
			row = map[param[i]];
			if($("td[colId|='"+status+"']",row).text() == t.grid.statusData.I){
				$(map[param[i]]).remove();
			}else{
				$("td[colId|='"+status+"']",row).text(t.grid.statusData.D);
			}
		}
	}else if("getCheckRow" == tag){
		
		var trs = $("tbody tr",t);
		rows = [];
		
		for ( var i = 0; i < trs.length; i++) {
			if($(".col_check",trs[i]).attr("checked") == "checked"){
				rows[rows.length] = trs[i].rowNo; 
			}
		}
		return rows;
	}else if("setCheckRow" == tag){
		t = t[0];
		var trs = $("tbody tr",t);
		
		if(param != undefined){
			if($.isArray(param)) param = param;
			else param = [param];
		}else{
			param = [];
			var trs = $("tbody tr",t);
			
			for ( var i = 0; i < trs.length; i++) {
				param[param.length] = $(trs[i]).attr('rowNo');
			}
		}
		checked = (param2 == undefined ? "checked" : param2);
		
		trMap ={};
		for ( var i = 0; i < trs.length; i++) {
			trMap[trs[i].rowNo] = trs[i];
		}
		for ( var i = 0; i < param.length; i++) {
			$(".col_check",trMap[param[i]]).attr("checked",checked);
		}
		
	}else if("saveRowData" == tag){
		var trs = $("tbody tr",t);
		var head = t[0].grid.head;
		var redata = {};
		var status = "";
		for ( var i = 0; i < head.length; i++) {
			if(head[i].type == "status"){
				status = head[i].id;
				break;
			}
		}
		
		var saveFlag = (param == false || param != undefined ? false : true);
		
		for ( var i = 0; i < trs.length; i++) {
			rowData = {};
			row = trs[i];
			sd = $("td[colId|='"+status+"']",row).text() ;
			
			if(	sd == t[0].grid.statusData.I 
				|| sd == t[0].grid.statusData.U 
				|| sd == t[0].grid.statusData.D 
			   ){
				rowData[status] = sd;
				for ( var j = 0; j < head.length; j++) {
					td = $("td[colId|='" + head[j].id + "']",row);
					
					if(head[j].type == "text"){
						inp = $("input",td);
						if(inp.length > 0){
							rowData[head[j].id] = inp.val();
						}else{
							rowData[head[j].id] = td.text();
						}
					}else if(head[j].type == "select"){
						var inp = $("select",td);
						
						if(inp.length > 0){
							rowData[head[j].id] = inp.val();
						}else{
							
							svv = head[j].selectKeyMap[td.text()];
							
							rowData[head[j].id] = (svv?svv:"");
						}
						
					}else if(head[j].type == "check"){
						
						inp = $("input",td);
						if(inp.length > 0){
							rowData[head[j].id] = ( inp.attr("checked") == "checked" );
						}else if(td.text() == head[j].checker.ok){
							rowData[head[j].id] = true;
						}else{
							rowData[head[j].id] = false;
						}
					}else if(head[j].type == "hidden"){
						rowData[head[j].id] = td.text();
					}
					
				}
				redata[row.rowNo] = rowData;
				saveFlag = false;
			}
			
		}
		if(saveFlag){
			alert("저장할 항목이 없습니다.");
			return;
		}
		
		return redata;
	}else if("reLoad" == tag){
		 t.each(function(){
			 $(".allcheck", this).removeAttr("checked");
			 if(!this.grid.reload)return;
			 this.grid.searchMethod(this.grid.reload.url, this.grid.reload.param);
		 });
		 
	}else if("getRowData" == tag){
		t = t[0];
		var trs = $("tbody tr",t);
		head = t.grid.head;
		redata = {};
		rows_rowNo = {};
		pp = [];
		
		if(param != undefined){
			if($.isArray(param)) pp = param;
			else pp = [param];
		}else{
			for ( var i = 0; i < trs.length; i++) {
				pp[i] = trs[i].rowNo;
				
			}
		}
		
		for ( var i = 0; i < trs.length; i++) {
			rows_rowNo[trs[i].rowNo] = trs[i];
		}
		for ( var i = 0; i < pp.length; i++) {
			
			row = rows_rowNo[pp[i]];
			rowData = $.coGridUtils.getData(head,row);
			redata[row.rowNo] = rowData;
		}
		if(param != undefined && !$.isArray(param)){
			return redata[param];
		} else{
			return redata;
		}
	}else if("insert" == tag){
		t = t[0];
		$("tfoot",t).css("display","none");
		var head = t.grid.head;
		var rowNo = t.grid.newRowCount++ ;
		
		var rowData = $("<tr rowNo='n_"+rowNo+"'></tr>");
		
		if(!param3 || param3 == 'first' || param3 != 'last'){
			rowData.prependTo($("tbody",t));
		}else{
			rowData.appendTo($("tbody",t));
		}
		
		//No 가 있을경우
		if(t.grid.rowCount){ rowData.append("<td></td>"); }
		if(t.grid.checkbox){ rowData.append("<td><input type='checkbox' class='col_check' rowNo='n_"+rowNo+"'></td>"); }
		
		for ( var i = 0; i < head.length; i++) {
			type = head[i].type;
			
			colInput = param[head[i].id];
			colInput = ( colInput == undefined ? "" : colInput);
			var td = $("<td colId='"+ head[i].id +"'></td>").appendTo(rowData);
			
			if(type == "status"){
				if(!colInput && colInput == ''){
					colInput = t.grid.statusData.I;
				}
			}else if(type == "text"){
				colInput = colInput;
			}else if(type == "select"){
				colInput = head[i].selectValMap[colInput];
			}else if(type == "check"){
				if(colInput){
					colInput = head[i].checker.ok;
				}else{
					colInput = head[i].checker.no;
				}
			}else if(type == "button"){
				colInput = $('<a href="#" name="'+ head[i].id +'" class="tblBtn button"><span>'+head[i].btnName +'</span></a>');
				colInput.click(function(){
					var rowNo = $(this).parents("tr").attr("rowNo");
					colId = $(this).parent().attr("colId");
					var click = t.grid.head_id[colId].click;
					return click(rowNo);
				});
			}else if(type == "hidden"){
				colInput = colInput;
				td.css("display","none");
			}
			
			if(type == "button"){
				colInput.appendTo(td);
			}else{
				td.text(colInput);
			}
		}
		
		if(!t.grid.loadData){
			t.grid.loadData = {};
		}
		if(!t.grid.loadData.rowList){
			t.grid.loadData.rowList = {};
		}
		t.grid.loadData.rowList["n_"+rowNo] = param;
				
		if($.isFunction(param2))param2("n_"+rowNo);
	}else if("remove" == tag){
		t = t[0];
		var trs = $("tbody tr",t);
		head = t.grid.head;
		
		map = {};
		
		if(!$.isArray(param)){
			param = [param];
		}
		
		for ( var i = 0; i < trs.length; i++) {
			map[trs[i].rowNo] = trs[i];
		}
		
		for ( var i = 0; i < param.length; i++) {
			$(map[param[i]]).remove();
		}
	}else if("highlight" == tag){
		t = t[0];
		flag = (param2 != undefined ? param2 : true);
		var trs = $("tbody tr[rowNo|='" + param+ "']",t);
		if(flag){
			trs.addClass("tr_highlight");
		}else{
			trs.removeClass("tr_highlight");
		}
		
	
	}else if("getHighlightRowNos" == tag){
		var trs = $("tbody .tr_highlight",t);
		reRowNos = [];
		for ( var i = 0; i < trs.length; i++) {
			$.coUtils.arrayAdd(reRowNos,trs[i].rowNo);
		}
		return reRowNos;
	}else if("setCol" == tag){
		t = t[0];
		var td = $("tbody tr[rowNo|='" + param+ "'] td[colId|='" + param2 + "']",t);
		
		head = t.grid.head_id[param2];
		if(head.type == "select"){
			if(head.selectKeyMap[param3] != undefined){
				param3 = head.selectValMap[param3];
			};
		}else if(head.type == "check"){
			if(head.checker.ok == param3){
				param3 = head.checker.ok ;
			}else{
				param3 = head.checker.no;
			}
		}
		
		td.text(param3);
		
	}else if("getCol" == tag){
		t = t[0];
		
		head = t.grid.head_id[param2];
		if(head.hidden != true){
			
			var td = $("tbody tr[rowNo|='" + param+ "'] td[colId|='" + param2 + "']",t);
			val = td.text();
			if(head.type == "select"){
				if(head.selectKeyMap[val] != undefined){
					val = head.selectKeyMap[val];
				};
			}else if(head.type == "check"){
				if(head.checker.ok == val){
					val = true;
				}else{
					val = false;
				}
			}
		}else{
			val = t.grid.loadData.rowList[param][param2];
		}
		return val ;
		
	}else if("unCheck" == tag){
		var trs = $("tbody tr",t);
		
		if(param == undefined){
			$(".col_check",t).each(function(){
				$(this).removeAttr("checked");
			});
			
		}else{
			if(!$.isArray(param)){
				param = [param];
			}
			for ( var i = 0; i < trs.length; i++) {
				for ( var i = 0; i < param.length; i++) {
					if(trs[i].rowNo == param[i]){
						$(".col_check",trs[i]).removeAttr("checked");
					}
				}
			}
		}
		return rows;
	}else if("clean" == tag){
		 t.each(function(){
			 $("tfoot",this).css("display","none");
			 $(".allcheck", this).removeAttr("checked");
			 this.grid.reload = undefined;
			 this.grid.loadData = undefined;
			 $("tbody",this).html("");
			 
		 });
	}else if("getColElement" == tag){
		
		var td = $("tbody tr[rowNo|='" + param+ "'] td[colId|='" + param2 + "']",t);
			
		var node = $(":first-child",td);
		if(node.length > 0){
			return node[0];
		}else{
			return td.text();
		}
	
	}else if("rowLength" == tag){
		
		var rows = $("tbody tr",t);
		return rows.length;
	}
	}catch(e){
		alert("오류가 발생 하였습니다.\n\n오류메세지[" + e + "]");
	}
};
/**********************************************************/
/**********************************************************/
/**********************************************************/
/**********************************************************/

jQuery.coGridUtils = {
	 tdCreate_button : function(handler, click){
		handler.click(function(){
			var rowNo = $(this).parents("tr").attr("rowNo");
			return click(rowNo);
		});
		return handler;
	}
	, tdCreate : function(head, data_text, row_no){
		data = data_text;
		tdHtml = "";
		type = head.type;
		if(type == "button"){
			tdHtml += '<a href="#" name="'+ head.id +'" class="tblBtn button"><span>'+head.btnName +'</span></a>';
		//	tdHtml += "<input type='button' name='"+ head.id +"' value='"+head.btnName +"'/>";
		}else if(type == "status"){
			tdHtml +="";
		}else{
			if(type == "select"){
				selval = head.selectValMap[data];
				data = (selval != undefined ? selval : data);
			}else if(type == "check"){
				data = (data == 'Y' ? head.checker.ok : head.checker.no);
			}else{
				//나머지는 텍스트로 인식
				data = $.coUtils.textToHtml(data);
			}
			tdHtml += ( data == undefined ? "" : data );
			
			if(head.formatter){
				ht = head.formatter(row_no,head.id,tdHtml, data_text);
				tdHtml = (ht == undefined ? "" : ht);
			}
		}
		
		return tdHtml;
	},
	getData : function (head, row){
		data = {};
		for ( var j = 0; j < head.length; j++) {
			if(head.hidden != true){
				
				td = $("td[colId|='" + head[j].id + "']",row);
				
				if(head[j].type == "text"){
					inp = $("input",td);
					if(inp.length > 0){
						data[head[j].id] = inp.val();
					}else{
						data[head[j].id] = td.text();
					}
				}else if(head[j].type == "select"){
					var inp = $("select",td);
					
					if(inp.length > 0){
						data[head[j].id] = inp.val();
					}else{
						svv = head[j].selectKeyMap[td.text()];
						data[head[j].id] = (svv?svv:"");
					}
					
				}else if(head[j].type == "check"){
					
					inp = $("input",td);
					if(inp.length > 0){
						data[head[j].id] = ( inp.attr("checked") == "checked" );
					}else if(td.text() == head[j].checker.ok){
						data[head[j].id] = true;
					}else{
						data[head[j].id] = false;
					}
				}else if(head[j].type == "checkbox"){
					inp = $("input",td);
					if(inp.length > 0){
						data[head[j].id] = ( inp.attr("checked") == "checked" );
					}					
				}else if(head[j].type == "status"){
					
					data[head[j].id] = td.text();
				}else if(head[j].type == "hidden"){
					
					data[head[j].id] = td.text();
				}
			}else{
				data[head[j].id] = t.grid.loadData.rowList[row][head[j].id];
			}
		}
		return data;
	},
	changeEditMode : function (row, grid, rowData,rowNo, mode){
		var head = t.grid.head;
		var rowData = t.grid.loadData.rowList[rowNo];
		
		for ( var i = 0; i < head.length; i++) {
			col = $("td[colId|='" +head[i].id+"']",row);
			if(!col)continue;
			if(head[i].edit == false)continue;
			if(head[i].updatemode == false)continue;
			
			type = head[i].type;
			if(type != "status"){
				colInput = $(head[i].tempHtml);
				
				if(rowData){
					if(type == "text"){
						colInput.val(rowData[head[i].id]);
					}else if(type == "select"){
						colInput.val(rowData[head[i].id]);
					}else if(type == "check"){
						if( rowData[head[i].id] == "true" ){
							colInput.attr("checked", "checked");
						}else{
							colInput.removeAttr("checked");
						}
					}
				}
			
				col.html("");
				colInput.appendTo(col);
			}else{
				if(mode == 'I'){
					col.html(grid.statusData.I);
				}else if(mode == 'U'){
					col.html(grid.statusData.U);
				}
			}
		}
	},
	hiddenCol : function (hid,gridId, id, name , taget, width){
		var grid = $("#" + gridId);
		
		th = $("th[h_col='"+id+"'", grid);
		var tds = $("td[colId='"+id+"'", grid);
		var col = $("col[propName='"+id+"'", grid);
		var head = grid[0].grid.head_id[id];
		html = "";
		if(hid){
			width = col.attr("width");
			$("td[colId='"+id+"'", grid).html("");
			html += '<a href="javascript:$.coGridUtils.hiddenCol(false,\''+gridId+'\',\''+id+'\',\''+name+'\',this,\''+width+'\');"  class="button hiddenButtion"><span>+</span></a>';
			col.attr("width","15px");
			grid[0].hidden = true;
			head.hidden = true;
		}else{
			html += name + ' <a href="javascript:$.coGridUtils.hiddenCol(true,\''+gridId+'\',\''+id+'\',\''+name+'\',this);"  class="button hiddenButtion"><span>-</span></a>';
			head = grid[0].grid.head_id[id];
			head.hidden = false;
			rowList = grid[0].grid.loadData.rowList;
				
			for ( var j = 0; j < tds.length; j++) {
				var td = tds[j];
				tdHtml = $.coGridUtils.tdCreate(head, rowList[j][id]);
				$(td).html(tdHtml);
			}
			col.attr("width",width);
		}
		th.html(html);
	}
};
jQuery.coUtils = {	
	listToParam : function(obj , chkFun){
		if(!obj)return;
		reData = "";
		for(var o in obj){
			for ( var d in obj[o]) {
				
				 if(chkFun && chkFun[d]){
					 ck = chkFun[d](obj[o][d],d,o);
					 if(ck == false) return;
				 }
				 reData += d + "=" + encodeURI(obj[o][d]) + "&";
			}
		}
		return reData;
	},
	objectToParam : function(obj){
		if(!obj)return;
		reData = "";
		for(var o in obj){
			reData += o + "=" + encodeURI( ( obj[o]  == undefined ?"" :  obj[o] )) + "&";
		}
		return reData;
	},
	isEmpty : function(d){
		return (d == undefined || d == null || "" == d);
	},
	chengeModify : function (selector, tag, rowNo , colId){
		var row = $(selector +" tbody tr[rowNo|='" +rowNo+"']");
		if(!colId) colId = "modify";
		var col = $("td[colId|='"+colId+"']",row);
		
		var bt = $(".button",col);
		
		span = $("span",bt);
		if(tag == "U"){
			
			if(span.html() == "수정"){
				span.html("취소");
				bt.unbind("click").click(function(){
					$(selector ).coGrid("resetRow", rowNo);
					return false;
				});
			}
		}else if(tag == "D"){
			span.html("취소");
			bt.unbind("click").click(function(){
				$(selector ).coGrid("deleteRows", [rowNo]);
				return false;
			});
		}
	},
	arrayAdd : function(array,val){
		if(array == undefined) array = [];
		array[array.length] = val;
	},
	textToHtml : function (data){
		if(data && data.replace){
			data = data
				.replace(/&/g,"&amp;")
				.replace("\"","&quot;")
				.replace(/</g,"&lt;")
				.replace(/>/g,"&gt;")
				.replace(/\s/g,"&nbsp;");
		}
		return data;
	},
	datepicker : function (selector , option){
		d_option = {    
				 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],    
				 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],    
				 dateFormat: 'yy-mm-dd',    
//				 buttonText: ' ',    
//				 buttonImage: contextPath + '/images/icon_calendar.gif',  
//				 buttonImageOnly : true,
				 prevText: '이전달',    
				 nextText: '다음달',    
//				 showOn: 'both',    
				 changeMonth: true,    
				 changeYear: true  };
		
		if(option) for ( var ele in option) {
			d_option[ele] = option[ele];
		}
		
		if(selector.datepicker != undefined){
			selector.datepicker(d_option); 
		}else{
			selector = $( selector ).datepicker(d_option); 
		}
		
		return selector;
	}
	
	
};


/*

-- 한글모드 --

<input type="text" size="10" style="ime-mode:active">

-- 영문모드 --

<input type="text" size="10" style="ime-mode:inactive">

-- 오직 영문 모드 -- 이경우에는 한/영 키를 바꿔도 영문만 죽어라 입력됨!

<input type="text  size="10" style="ime-mode:disabled">
*/



