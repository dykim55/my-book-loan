function getCurrentTime() {
// 현재 시각을 Time 형식으로 리턴
	return toTimeString(new Date(), 14);
}

function getCurrentDay() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
	var day = date.getDate();

	if (("" + month).length == 1) { month = "0" + month; }
	if (("" + day).length == 1) { day = "0" + day; }

	return ("" + year + month + day);
}

function toTimeString(date, length) { //formatTime(date)
// 자바스크립트 Date 객체를 Time 스트링으로 변환 
// parameter date: JavaScript Date Object
	var year = date.getFullYear();
	var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
	var day = date.getDate();
	var hour = date.getHours();
	var min = date.getMinutes();
	var sec = date.getSeconds(); 

	if (("" + month).length == 1) { month = "0" + month; }
	if (("" + day).length == 1) { day = "0" + day; }
	if (("" + hour).length == 1) { hour = "0" + hour; }
	if (("" + min).length == 1) { min = "0" + min; }
	if (("" + sec).length == 1) { sec = "0" + sec; }

	if (length == 8) {
		return ("" + year + month + day);
	} else { 
		return ("" + year + month + day + hour + min + sec);
	}
}

function toTimeObject(time) { //parseTime(time)
/////////////////////////////////////////////////////
// Time 스트링을 자바스크립트 Date 객체로 변환 parameter time: Time 형식의 String
	var year = time.substr(0,4);
	var month = time.substr(4,2) - 1; // 1월=0,12월=11
	var day = time.substr(6,2);
	var hour = time.substr(8,2);
	var min = time.substr(10,2);
	
	return new Date(year,month,day,hour,min);
}

function getDayInterval(time1,time2) {
/////////////////////////////////////////////////////
// 두 Time이 며칠 차이나는지 구함
	var date1 = toTimeObject(time1);
	var date2 = toTimeObject(time2);
	var day = 1000 * 3600 * 24; //24시간

	return parseInt((date2 - date1) / day, 10) + 1;
}

function shiftTime(time,y,m,d) {
// 주어진 Time 과 y년 m월 d일 차이나는 Time을 리턴
	var date = toTimeObject(time);
	date.setFullYear(date.getFullYear() + y); //y년을 더함
	date.setMonth(date.getMonth() + m); //m월을 더함
	date.setDate(date.getDate() + d); //d일을 더함
	return toTimeString(date,8);
}

function format_YYYYMMDD(num, separator) {
// 연월일(YYYYMMDD)의 유효성을 체크하고 표준 날짜 포맷 (YYYY/MM/DD) 으로 변환하여 리턴 (주의 : 이 함수의 파라미터는 객체임 (input object))

	var year, month, day;
	
	if (isNaN(num)) { 
		window.alert("숫자로만 작성하셔야 합니다");
		return object;
	}
	
	if( num != 0 && num.length == 8 ) {
		year = num.substring( 0, 4 );
		month = num.substring( 4, 6 ); 
		day = num.substring(6,8);
		num = year + separator + month + separator + day;
	} 
	else {
		num = "";
		window.alert("날짜 입력형식 오류입니다. 다시 한번 확인하시고 입력해 주세요.");
		return num;
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
