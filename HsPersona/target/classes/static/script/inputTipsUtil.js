//定义全局变量用于储存提示层 
var liketips; 

//监听改动或得到焦点事件 

//禁用chrome和firefox浏览器自带的自动提示 
$('#generalSearchKey').attr("autocomplete","off"); 
function searchTips(obj,url,param){
    $this=obj; 
    //获取input框位置并计算提示层应出现的位置 
    var top=1*$this.offset().top+25; 
    var left=1*$this.offset().left;
    var width=1*$this.width()+6; 

    //重建储存提示层并让其在适当位置显示 
    $(liketips).remove(); 
    liketips=document.createElement('div'); 
    $liketips=$(liketips); 
    //class样式这里不提供，最主要是position:absolute 
    $liketips.addClass("liketips"); 
    $liketips.css({top:top+'px',left:left+'px',width:(width)+'px'});
    $liketips.css('background-color','#FFF');
    $liketips.css('z-index',999);
    $('#searchTips').css('z-index',999);
    $('#searchTips').css('position','relative');
    //加载前先显示loading动态图 
   // $liketips.append('<img src="/images/loading.gif" border="0" />'); 
    $liketips.appendTo($('#searchTips')); 
    $liketips.show(); 

    //定义ajax去获取json，type参数通过data-type设置，keyword则是目前已输入的值 
    //返回值以table形式展示 
	/*var htmlcode="<table cellspacing='0' cellpadding='2'><tbody>"; 
        for(var i=0;i<10;i++){ 
            //这里我需要用到value和title两项，所以用data-value传递多一个参数，在回车或鼠标点击后赋值到相应的地方，以此完美地替代select 
            htmlcode+='<tr data-value="ceshi '+i+'"><td  class="data-key">ceshi '+i+'</td></tr>'; 
        } 
        htmlcode+="</tbody></table><span>请务必在此下拉框中选择</span>"; 
        //把loading动态图替换成内容 
        $liketips.html(htmlcode); */
    $.ajax({
    	type : 'POST',
		url : url,
		data : param,
		dataType : 'json',
		success : function(data) {
			if(data.length==0){
				$(liketips).fadeOut('fast');
				return ;
			};
			//返回值以table形式展示 
			var htmlcode="<table cellspacing='0' cellpadding='2'><tbody>"; 
			$.each(data,function(i,item){
				//这里我需要用到value和title两项，所以用data-value传递多一个参数，在回车或鼠标点击后赋值到相应的地方，以此完美地替代select 
				htmlcode+='<tr data-value="'+item.key+'"><td  class="data-key">'+item.value+'</td></tr>'; 
			});
			
		    htmlcode+="</tbody></table>"; 
		    //把loading动态图替换成内容 
		    $liketips.html(htmlcode);
		}
    	
    });
}; 

//焦点消失时确保数据来自选项，隐藏提示框体 
$('#generalSearchKey').blur(function(){
	//失去焦点时隐藏提示框体
	$(liketips).fadeOut('fast'); 
    //因为鼠标点击时blur动作结算在click之前，setTimeout是为了解决这个问题 
	
}); 

//监听键盘动作 
$('#generalSearchKey').keydown(function(event){
	if(!liketips ||$liketips.is(":hidden"))return;
    $this=$(this); 
    if(event.keyCode==40){ 
        //按键是向下 
        $nowtr=$('tr.selectedtr'); 
        //如果已存在选中，则向下，否则，选中选单中第一个 
        if($nowtr.length>0){ 
            $nexttr=$nowtr.next('tr') 
            //如果不是最后选项，向下个tr移动，否则跳到第一个tr 
            if($nexttr.length>0){ 
                $('tr.selectedtr').removeClass(); 
                $nexttr.addClass('selectedtr'); 
            } 
            else{ 
                $('tr.selectedtr').removeClass(); 
                $nowtr.parent().find('tr:first').addClass('selectedtr'); 
            }
        } 
        else{ 
            $('.liketips').find('tr:first').addClass('selectedtr'); 
        }
    } 
    else if(event.keyCode==38){ 
        //按键是向上 
        $nowtr=$('tr.selectedtr'); 
        //如果已存在选中，则向下，否则，选中选单中第一个 
        if($nowtr.length>0){ 
            $prevtr=$nowtr.prev('tr') 
            //如果不是最后选项，向下个tr移动，否则跳到第一个tr 
            if($prevtr.length>0){ 
                $('tr.selectedtr').removeClass(); 
                $prevtr.addClass('selectedtr'); 
            } 
            else{ 
                $('tr.selectedtr').removeClass(); 
                $nowtr.parent().find('tr:last').addClass('selectedtr'); 
            } 
        } 
        else{ 
            $('.liketips').find('tr:last').addClass('selectedtr'); 
        }
    } 
	
    else if(event.keyCode==13){ 
        //按键是回车，则确定返回并隐藏选框 
        $(liketips).fadeOut('fast'); 
    }
	
	$nowtr=$('tr.selectedtr'); 
	if($nowtr.length==1){ 
		$this.val($nowtr.text());
		//若是枚举型 需要isOk=1才可以通过
		$('#generalSearchKey').attr('realKey',$nowtr.data('value'));
	}  
}); 

//监听鼠标动作，mouseover改变选中项 
$(document).delegate('.liketips td','mouseover',function(){ 
    $nowtr=$(this).parent(); 
    $nowtr.siblings('tr').removeClass(); 
    $nowtr.addClass('selectedtr'); 
}); 

//监听鼠标动作，click选定 
$(document).delegate('.liketips td','click',function(){ 
    $nowtr=$(this).parent(); 
    if($nowtr.length==1){ 
        $('#generalSearchKey').val($nowtr.text());
        $('#generalSearchKey').attr('realKey',$nowtr.data('value'));
    } 
    $(liketips).fadeOut('fast');
    
    $('#searchBtn').click();
}); 