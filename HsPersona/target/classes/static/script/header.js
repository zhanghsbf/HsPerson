var sessionOutAlertNum=0,globalProjectName="";
$.ajaxSetup({
    contentType : "application/x-www-form-urlencoded;charset=utf-8",
    complete : function(XMLHttpRequest, textStatus) {
        var sessionstatus = XMLHttpRequest.getResponseHeader("sessionstatus");
    	globalProjectName = XMLHttpRequest.getResponseHeader("projectname");
        if (sessionstatus == "timeout") {
            if(sessionOutAlertNum==0)
            {
                sessionOutAlertNum++;
                alert("登录超时或没有任何权限，请重新登录");
                window.parent.location.href = globalProjectName+"/system/login!to.do";
            }
        }
    }
});
function times(t)
{
    if(t==null || t=="") return "";
    var datetime = new Date(t);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1;
    month = (month<10)?("0"+month):month;
    var date = datetime.getDate();
    date = (date<10)?("0"+date):date;
    var hour = datetime.getHours();
    hour = (hour<10)?("0"+hour):hour;
    var minute = datetime.getMinutes();
    minute = (minute<10)?("0"+minute):minute;
    var second = datetime.getSeconds();
    second = (second<10)?("0"+second):second;
    return year + "-" + month + "-" + date+" "+hour+":"+minute+":"+second;
}
function dates(t)
{
    if(t==null || t=="") return "";
    var datetime = new Date(t);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1;
    month = (month<10)?("0"+month):month;
    var date = datetime.getDate();
    date = (date<10)?("0"+date):date;
    return year + "-" + month + "-" + date;
}
function doubles2(t)
{
    if(t==0) return "0.00";
    if(t==null || t=="") return "";
    if(t-0==0) return "0.00";
    t = t.toFixed(2);
    var  re=/(-?\d+)(\d{3})/;
    while(re.test(t))
        t=t.replace(re,"$1,$2");
    return t;
}
function isOrNo(v){
	return v==0?"否":"<font color='blue'><b>是</b></font>";
}

function isNoNegativeInteger(str){
	var reg = /^\d+$/;
	return reg.test(str);
}

function isEnglish(str){
	var reg = /^[a-zA-Z]+$/;
	return reg.test(str);
}

function isPositiveInteger(str){
	var reg = /^\+?[1-9][0-9]*$/;
	return reg.test(str);
}
/**
 * 英文字母开头，可包含数字英文字母下划线
 * @param str
 * @returns
 */
function isCode(str){
	var reg = /^[a-zA-Z]{1}\w*$/;
	return reg.test(str);
}
