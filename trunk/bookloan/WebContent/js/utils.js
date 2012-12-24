function format_YYYYMMDD(object) {
// 연월일(YYYYMMDD)의 유효성을 체크하고 표준 날짜 포맷 (YYYY/MM/DD) 으로 변환하여 리턴 (주의 : 이 함수의 파라미터는 객체임 (input object))

	var num, year, month, day;
	num=object.value;

	while (num.search("/") != -1){ 
		num = num.replace("/","");
	}

	if (isNaN(num)) { 
		window.alert("숫자로만 작성하셔야 합니다");
		object.focus();
		return "";
	}
	
	if( num != 0 && num.length == 8 ) {
		year = num.substring( 0, 4 );
		month = num.substring( 4, 6 ); 
		day = num.substring(6);
		if(isValidDay(year,month,day)==false) {
			num = "";
			window.alert("유효하지 않는 일자입니다. 다시 한번 확인하시고 입력해 주세요.");
			object.focus();
			return "";
		} 
		num = year+"/"+month + "/" + day;
	} else {
		num = "";
		window.alert("날짜 입력형식 오류입니다. 다시 한번 확인하시고 입력해 주세요.");
		object.focus();
		return "";
	} 
	return num;
}

function format_YYYYMMDDHHMM(object) {

	var num, year, month, day;
	num=object;
	
	while (num.search("/") != -1) { 
		num = num.replace("/","");
		num = num.replace(":","");
		num = num.replace(" ","");
	}
	
	if (isNaN(num)) { 
		window.alert("숫자로만 작성하셔야 합니다");
		return object;
	}
	
	if( num != 0 && num.length == 14 ) {
		year = num.substring( 0, 4 );
		month = num.substring( 4, 6 ); 
		day = num.substring(6,8);
		hh = num.substring(8,10);
		mm = num.substring(10,12);
		ss = num.substring(12,14);
		num = year+"-"+month + "-" + day+" "+hh+":"+mm+":"+ss;
	} 
	else {
		num = "";
		window.alert("날짜 입력형식 오류입니다. 다시 한번 확인하시고 입력해 주세요.");
		return object;
	} 
	return num;
}

function isValidDay(yyyy, mm, dd) {
//유효한(존재하는) 일(日)인지 체크
	var m = parseInt(mm,10) - 1;
	var d = parseInt(dd,10);

	var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
		end[1] = 29;
	}
	return (d >= 1 && d <= end[m]);
}

function addComma(strSrc, bSymbol) {
    var strSymbol = '';
    var retValue  = '';
    var strTempSymbol = '';
    var strTempDotValue = '';
    var nLen      = 0;
    
    try {
        if (bSymbol == null) {
            bSymbol = false;
        }
        strSrc = strSrc.trim();
        if (strSrc.indexOf('.') > 0) {
            var nIndex = strSrc.indexOf('.');
            strTempDotValue = strSrc.substring(nIndex);
            strSrc = strSrc.substring(0, nIndex);
        }
   
        strTempSymbol = strSrc.substr(0,1);
        if (strTempSymbol == '+') {
            strSymbol = '+';
            strSrc = strSrc.substring(1);
        }
        if (strTempSymbol == '-') {
            strSymbol = '-';
            strSrc = strSrc.substring(1);
        }
        nLen = strSrc.length;
        for (var i=1; i <= nLen; i++) {
            retValue = strSrc.charAt(nLen - i) + retValue;
            if ((i % 3 == 0) && ((nLen - i) != 0)) {
                retValue = "," + retValue;
            }
        }
        if (bSymbol) {
            if (strSymbol == '') {
                strSymbol = '+';
            }
        } else {
            if (strSymbol == '+') {
                strSymbol = '';
            }
        }
        return strSymbol + retValue + strTempDotValue;
    } catch (e) { }
}
