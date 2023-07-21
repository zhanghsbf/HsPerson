/**
 * 分页页码计算，该函数主要处理分页事项，主要根据当前页和页面大小计算需要显示的分页页面序号信息。每次最多只显示10个分页页面序号信息
 * @param pageNow 当前页面
 * @param pageSum 总页数
 * @author zxc
 * @date 2016-07-15
 */
function pagNumCalcute(pageNow,pageSum){
	var array = new Array();
	//计算总页数
	if(pageSum<=10){
		//若总数小于等于10
		for(var i=1;i<=pageSum;i++){
			array.push(i);
		}
	}else{
		//若总数大于10,若当前页面不大于6，则直接返回前10页，若当前页面大于6，始终将当前页放置在第6页的位置
		if(pageNow<7){
			//若当前页面不大于6，则直接返回前10页
			for(var i=1;i<=10;i++){
				array.push(i);
			}
		}else{
			if(pageSum-pageNow>=4){
				for(var i=pageNow-5;i<pageNow+5;i++){
					array.push(i);
				}
			}else{
				for(var i=pageSum-9;i<=pageSum;i++){
					array.push(i);
				}
			}
		}
	}
	return array;
}
/**
 * 分页工具类，配置好放置分页的div 即可，div 的id定义为comment
 * @param pageNow 当前页面序号
 * @param total 信息总条数
 * @param pageSize 页面大小
 * @author zxc
 * @date 2016-07-15
 */
function pagingUtil(pageNow,total,pageSize){
	console.log(pageNow);
	//计算页面总数
	var pageSum = parseInt((total+pageSize-1)/pageSize);
	//获取分页序号信息
	var array = pagNumCalcute(pageNow,pageSum);
	//将其插入到页面中
	pading2Div(array,pageNow,pageSum);
}
/**
 * 将分页数据添加到分页页面div中
 * @param array 分页数组
 * @param pageNow 当前页面序号
 * @param pageSum 页面总数
 */
function pading2Div(array,pageNow,pageSum){
	var page = $('#page');
	page.empty();
	for(var i=0;i<array.length;i++){
		var span=$('<span class="padingIndex" onclick="padingIndexClick('+array[i]+','+pageSum+')"></span>');
		span.addClass('pageIndex');
		if(array[i]==pageNow){
			//激活显示
			span.addClass('pageActive');
		}
		span.html(array[i]);
		//添加到分页布局中
		page.append(span);
	}
}

//分页 start为开始序号，end为结束序号，pageNow为当前页码
function pager2Div(start, end, pageNow) {
	var page = $('#page');
	page.empty();
	if((start-0)==(end-0)){
		//只有一页
		return;
	}
	for (var i = (start-0); i <= (end-0); i++) {
		var aHtml = $('<a href="javascript:void(0)" onclick="padingIndexClick(' + i + ')"></a>');
		aHtml.addClass('pageIndex');
		if (i == pageNow) {
			//激活显示
			aHtml.addClass('pageActive');
		}
		aHtml.html(i);
		//添加到分页布局中
		page.append(aHtml);
		page.append(" ");
	}
}

function addResultHtml(url,item){
	var div = $('<div></div>');
	//标题
	var titleDiv = $('<div></div>');
	titleDiv.html('<a href="'+url+'" target="_blank">'+searchHighLight(item.name+"，"+item.age+"，"+item.gender)+'</a>');
	titleDiv.addClass('person_title');
	div.append(titleDiv);
	//标签
	var tagDiv = $('<div></div>');
	tagDiv.addClass('person_tag');
	var tagStr = '';
	if(item.tagNames!=undefined){
		$.each(item.tagNames, function(j, tags) {
			tagStr=tagStr + '<a class="tag_item" href="javascript:void(0)" onclick="tagClick(\''+tags+'\')">'+searchHighLight(tags)+'</a>&nbsp;';
		});
	}
	if(tagStr!=''){
		tagDiv.html(tagStr);
		div.append(tagDiv);
	}
	div.addClass('content');
	//资金
	var financeDiv =$('<div></div>');
	financeDiv.addClass('person_content');
	
	financeDiv.html(item.description);
	div.append(financeDiv);
	return div;
}

function searchHighLight(str){
	//获取关键词
	var keyObj = $('#generalSearchKey');
	if(keyObj!=undefined && keyObj.val()!=undefined ){
		var key = keyObj.val();
		str = str.replace(key,'<span style="color:Red;">'+key+'</span>');
	}
	return str;
}

//标签top
function topTagBar(v) {
	var tagsData = new Array();
	$.each(v, function(i, item) {
		tagsData.push([item.tagName,parseInt(item.count)]);
	});
	if(tagsData.length==0){
		return ;
	}
	var bar = new D3c.Chart.Bar({
		data : tagsData,
		width : 450,
		height : 380,
		target : 'topTagBar',
		bgColor : '#FDFDFD',
		barWidth : 0.9,
		tips : {
			fontFamily : 'Verdana',
			fontSize : 10,
			fontAlign : 'start',
			rotate : -90,
			dev : 5
		},
		axis : {
			label : [ "标签名称", "数量" ],
			fontSize : 11,
			fontFamily : "Microsoft YaHei",
			fontAlign : 'end',
			rotate : -60,
			dev : -8,
			grid : 3
		},
		title : {
			dev : 50,
			text : "搜索结果中各标签个体数量TOP"+tagsData.length,
			height : 14,
			family : 'Microsoft YaHei',
			size:24
		}
	});
}
/*去空格*/
function Trim(str)
{ 
    return str.replace(/(^\s*)|(\s*$)/g, ""); 
}


/*遮罩层*/
/*开启遮罩层*/
function showOverlay(){
	//loading框
	loadingDiv();
	$('#bgLoad').height(pageHeight());
	$('#bgLoad').width(pageWidth());
	$('#bgLoad').css('background-color','#FFF');
	$('#bgLoad').css('position','absolute');
	$('#bgLoad').css('z-index','1001');
	$('#bgLoad').css('left',0);
	$('#bgLoad').css('top',0);
	//fadeTo第一个方法为速度，第二个方法为透明度
	//多重方式控制透明度，保证兼容性
	$('#bgLoad').fadeTo(200,0.5);
}
/*关闭遮罩层*/
function hideOverlay(){
	$('#bgLoad').fadeOut(200);
}
/*当前页面的高度*/
function pageHeight(){
	return document.body.scrollHeight;
}
/*当前页面的宽度*/
function pageWidth(){
	return document.body.scrollWidth;
}

function loadingDiv(){
	var t = scrollY()+windowHeight()/2;
	var l = scrollX();
	$('#loadDiv').width(windowWidth());
	$('#loadDiv').css('left',l+'px');
	$('#loadDiv').css('top',t+'px');
	$('#loadDiv').css('background-color','#FFF');
	$('#loadDiv').css('position','absolute');
	$('#loadDiv').css('z-index','1002');
}

//浏览器视口的高度
function windowHeight() {
    var de = document.documentElement;
    return self.innerHeight || (de && de.clientHeight) || document.body.clientHeight;
}

//浏览器视口的宽度
function windowWidth() {
    var de = document.documentElement;
    return self.innerWidth || (de && de.clientWidth) || document.body.clientWidth;
}

/* 浏览器垂直滚动位置 */
function scrollY() {
    var de = document.documentElement;
    return self.pageYOffset || (de && de.scrollTop) || document.body.scrollTop;
}

/* 浏览器水平滚动位置 */
function scrollX() {
    var de = document.documentElement;
    return self.pageXOffset || (de && de.scrollLeft) || document.body.scrollLeft;
}


