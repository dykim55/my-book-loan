
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
