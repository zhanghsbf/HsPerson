var propertyData = []
/**
 * ############################################################################
 * ##################       EasyUI的Menu控件扩展方法      ######################
 * ############################################################################
 */
//获取所有菜单元素
$.fn.menu.methods.getItems = function(jq){
	return $(jq[0]).children("div.menu-item");
}
//移除所有菜单
$.fn.menu.methods.removeItems = function(jq){
	$(jq[0]).children("div.menu-item").each(function(){
		$(jq[0]).menu("removeItem", this);
	});
}
//移除某个菜单的所有子菜单
$.fn.menu.methods.removeSubItems = function(jq,item){
	function removesub(el){
		if (el.submenu) {
			el.submenu.children("div.menu-item").each(function() {
				removesub(this);
			});
			var shadow = el.submenu[0].shadow;
			if (shadow) {
				shadow.remove();
			}
			el.submenu.remove();
		}
		$(el).remove();
	}
	if(item.submenu){
		item.submenu.children("div.menu-item").each(function() {
			removesub(this);
		});
	}
}
/**
 * ############################################################################
 * ##################       公式维护界面使用的函数      ########################
 * ############################################################################
 */
/**
 * 公式界面添加行
 */
function doAddFormulaRow(){
	$('#dg1').datagrid('clearSelections');
	$('#dg1').datagrid('appendRow',{type:0,data:''});
}
/**
 * 公式界面删除选中的一行或多行
 */
function doDeleteFormulaRow(){
	var rows = $("#dg1").datagrid("getSelections");
    if(rows.length==0){
        $.messager.alert('提示','请选择需要删除的行'); 
        return;
    }
    for(var i=0;i<rows.length;i++){
    	$('#dg1').datagrid('deleteRow',$("#dg1").datagrid("getRowIndex",rows[i]));
    }
}
/**
 * 公式表格右键所在行增加属性数据（属性）
 * @param obj 被操作对象
 */
function doAddProperty(obj){
	var item = $('#menuPpt').menu('getItem', obj);
	var row = $("#dg1").datagrid("getSelected");
	if(row!=null){
		var index = $("#dg1").datagrid("getRowIndex",row)
		$('#dg1').datagrid('updateRow',{
			index: index,
			row: {type:1,data:item.text}
		});
	}
}
/**
 * 公式表格右键所在行增加变量数据（变量）
 * @param obj 被操作对象
 */
function doAddVariable(obj){
	var item = $('#menuPpt').menu('getItem', obj);
	var row = $("#dg1").datagrid("getSelected");
	if(row!=null){
		if(item.text=="{nowdate}"){
			$.messager.alert('提示','被判断属性的值的形式必须符合如下格式中的一种：20170101，2017-01-01，2017/01/01，2017-1-1，2017/1/1'); 
		}else if(item.text=="{nowtime}"){
			$.messager.alert('提示','被判断属性的值的形式必须符合如下格式中的一种：20170101080101，2017-01-01 08:01:01，2017/01/01 08:01:01，2017-1-1 8:1:1，2017/1/1 8:1:1，20170101，2017-01-01，2017/01/01，2017-1-1，2017/1/1');
		}
		var index = $("#dg1").datagrid("getRowIndex",row)
		$('#dg1').datagrid('updateRow',{
			index: index,
			row: {type:1,data:item.text}
		});
	}
}
/**
 * 公式表格右键所在行增加表达式（表达式）
 * @param obj 被操作对象
 */
function doAddExpress(obj){
	var item = $('#menuPpt').menu('getItem', obj);
	var row = $("#dg1").datagrid("getSelected");
	if(row!=null){
		var index = $("#dg1").datagrid("getRowIndex",row)
		$('#dg1').datagrid('updateRow',{
			index: index,
			row: {type:4,data:item.text}
		});
	}
}
/**
 * 公式表格右键所在行增加单目简单组操作（简单组操作Sum/count/avg）
 * @param obj 被操作对象
 */
function doAddGroup(obj){
	var item = $('#menuFunc').menu('getItem', obj);
	var row = $("#dg1").datagrid("getSelected");
	if(row!=null){
		var index = $("#dg1").datagrid("getRowIndex",row)
		var text = row.data;
		if(row.type!=1 & row.type!=2){
			$.messager.alert('提示',item.text+'必须选择属性或者不带组操作的公式（类型=1,2）');
		}else if(text.substring(0,1)=="{" && text.substring(text.length-1)=="}"){
			$.messager.alert('提示',item.text+'不能使用带大括号的变量');
		}else{
	    	$('#dg1').datagrid('updateRow',{
				index: index,
				row: {type:3,data:item.text+"("+row.data+")"}
			});
		}
	}
}
/**
 * 公式表格右键所在行增加countif组操作（条件组操作countif）
 * @param obj 被操作对象
 */
function doAddCifGroup(obj){
	var item = $('#menuFunc').menu('getItem', obj);
	var row = $("#dg1").datagrid("getSelected");
	if(row!=null){
		var index = $("#dg1").datagrid("getRowIndex",row)
		if(row.type!=4){
			$.messager.alert('提示',item.text+'必须选择逻辑式（类型=4）');
		}else{
	    	$('#dg1').datagrid('updateRow',{
				index: index,
				row: {type:3,data:item.text+"("+row.data+")"}
			});
		}
	}
}
/**
 * 公式表格右键进行的四则操作（四则）
 * @param operateType 操作类型
 * @param direction 操作数位置方向
 */
function doAddOperate(operateType,direction){
	var opt = ["+","-","*","/"];
	var rows = $("#dg1").datagrid("getSelections");
	if(rows.length!=2){
		$.messager.alert('提示','进行四则运算时必须且只能选择两行'); 
        return;
	}
	if((rows[0].type!=1 && rows[0].type!=2 && rows[0].type!=3) || (rows[1].type!=1 && rows[1].type!=2 && rows[1].type!=3)){
		$.messager.alert('提示','进行四则运算时选择的两行必须存在数据且不能为逻辑式（类型可以=1,2,3）'); 
        return;
	}
	var type=Math.max(2,rows[0].type,rows[1].type);//如果到了3，表示已经有过组操作，类型不降级
	var rowIndex0 = $("#dg1").datagrid("getRowIndex",rows[0]);
	var rowIndex1 = $("#dg1").datagrid("getRowIndex",rows[1]);
	if(direction==0){
		$('#dg1').datagrid('updateRow',{
			index: rowIndex0,
			row: {type:type,data:"(\03"+rows[0].data+"\03"+opt[operateType]+"\03"+rows[1].data+"\03)"}
		});
	}else{
		$('#dg1').datagrid('updateRow',{
			index: rowIndex0,
			row: {type:type,data:"(\03"+rows[1].data+"\03"+opt[operateType]+"\03"+rows[0].data+"\03)"}
		});
	}
	$('#dg1').datagrid('deleteRow',rowIndex1);
}

/**
 * 公式表格右键进行的sumif操作（条件组操作sumif）
 */
function doAddSifOperate(obj){
	var rows = $("#dg1").datagrid("getSelections");
	if(rows.length!=2){
		$.messager.alert('提示','进行双目运算时必须且只能选择两行'); 
        return;
	}
	if(!(rows[0].type==4 && (rows[1].type==1 || rows[1].type==2)) && !(rows[1].type==4 && (rows[0].type==1 || rows[0].type==2))){
		$.messager.alert('提示','进行sumif运算时一行必须为逻辑式（类型=4）另一行必须为属性、变量或普通公式（类型=1,2）'); 
        return;
	}
	var rowIndex0 = $("#dg1").datagrid("getRowIndex",rows[0]);
	var rowIndex1 = $("#dg1").datagrid("getRowIndex",rows[1]);
	var x1=-1,x2=-1;
	if(rows[0].type==4 && (rows[1].type==1 || rows[1].type==2)){
		x1=0;
		x2=1;
	}else if(rows[1].type==4 && (rows[0].type==1 || rows[0].type==2)){
		x1=1;
		x2=0;
	}
	var rows2Data = rows[x2].data.replace(/\03/g,"\05")
	if(x1!=-1 && x2!=-1){
		$('#dg1').datagrid('updateRow',{
			index: rowIndex0,
			row: {type:3,data:"sumif("+rows[x1].data+","+rows2Data+")"}
		});
		$('#dg1').datagrid('deleteRow',rowIndex1);
	}
}
/**
 * 公式维护界面下一步
 */
function doNext1(){
	var rows = $('#dg1').datagrid('getRows');
	var item = $('#menuExpress').menu('findItem', '逻辑式左侧');
	$('#menuExpress').menu('removeSubItems',item.target);
	for(var i=0;i<propertyData.length;i++){
		$('#menuExpress').menu('appendItem',{
			parent:item.target,
			iconCls:'icon-code',
			text:propertyData[i],
			id:propertyData[i],
			onclick:function(){
				doExpressLeft(this);
			}
		})
	}
	for(var i=0;i<rows.length;i++){
		if(rows[i].type==4){//表达式不添加到表达式窗口
			continue;
		}
		var tmpProperty = rows[i].data;
		var haved = false;
		for(var j=0;j<propertyData.length;j++){
			if(propertyData[j]==tmpProperty){
				haved = true;
				break;
			}
		}
		if(!haved){
			for(var j=0;j<i;j++){
				if(rows[j].data==tmpProperty){
					haved = true;
					break;
				}
			}
		}
		if(haved){//已经存在了，就不再添加
			continue;
		}
		if(tmpProperty==""){//内容为空，不添加
			continue;
		}
		if(tmpProperty.length>100){
			tmpProperty = tmpProperty.substring(0,100);
		}
		$('#menuExpress').menu('appendItem',{
			parent:item.target,
			iconCls:'icon-code',
			text:tmpProperty,
			id:rows[i].data,
			onclick:function(){
				doExpressLeft(this);
			}
		})
	}
	$('#w1').window('close'); 
	$('#w2').window({top:10});
	$('#w2').window('open'); 
}
/**
 * ############################################################################
 * ##################       表达式维护界面使用的函数      ######################
 * ############################################################################
 */
/**
 * 表达式界面添加行
 */
function doAddExpressRow(){
	$('#dg2').datagrid('clearSelections');
	$('#dg2').datagrid('appendRow',{type:0,leftData:'',operate:'',rightData:'',data:''});
}
/**
 * 表达式界面删除行
 */
function doDeleteExpressRow(){
	var rows = $("#dg2").datagrid("getSelections");
    if(rows.length==0){
        $.messager.alert('提示','请选择需要删除的行'); 
        return;
    }
    for(var i=0;i<rows.length;i++){
    	$('#dg2').datagrid('deleteRow',$("#dg2").datagrid("getRowIndex",rows[i]));
    }
}
/**
 * 表达式表格右键添加表达式左侧内容
 * @param obj : 表达式左侧内容所在菜单
 */
function doExpressLeft(obj){
	var item = $('#menuExpress').menu('getItem', obj);
	var row = $("#dg2").datagrid("getSelected");
	if(row!=null){
		if(row.type==0){
			var index = $("#dg2").datagrid("getRowIndex",row)
	    	$('#dg2').datagrid('updateRow',{
				index: index,
				row: {
					type:0,
					leftData:item.id,
					operate:row.operate,
					rightData:row.rightData,
					data:item.id+"\t "+row.operate+"\t "+row.rightData
				}
			});
		}else{
			$.messager.alert('提示','合并了的表达式不能再修改表达式左侧'); 
		}
	}
}
/**
 * 表达式表格右键添加表达式操作符
 * @param obj : 表达式操作符所在菜单
 */
function doExpressOpt(obj){
	var item = $('#menuExpress').menu('getItem', obj);
	var row = $("#dg2").datagrid("getSelected");
	if(row!=null){
		if(row.type==0){
			var index = $("#dg2").datagrid("getRowIndex",row)
	    	$('#dg2').datagrid('updateRow',{
				index: index,
				row: {
					type:0,
					leftData:row.leftData,
					operate:item.text,
					rightData:row.rightData,
					data:row.leftData+"\t "+item.text+" \t"+row.rightData
				}
			});
			doExpressRight();
		}else{
			$.messager.alert('提示','合并了的表达式不能再修改表达式操作符'); 
		}
	}
}
/**
 * 表达式表格右键添加表达式右侧内容
 * @param obj : 表达式右侧内容所在菜单
 */
function doExpressRight(){
	$.messager.prompt('提示','请输入表达式右侧内容，字符串使用英文单引号',function(text){
		if (text){
			var row = $("#dg2").datagrid("getSelected");
			if(isNaN(text) && text.length>1 && (text.substring(0,1)!="'" || text.substring(text.length-1)!="'")){
				$.messager.alert('提示','输入文字必须是数字或者由英文单引号括起的字符串'); 
				return;
			}
			if(row!=null){
				if(row.type==0){
					var index = $("#dg2").datagrid("getRowIndex",row)
			    	$('#dg2').datagrid('updateRow',{
						index: index,
						row: {
							type:0,
							leftData:row.leftData,
							operate:row.operate,
							rightData:text,
							data:row.leftData+"\t "+row.operate+" \t"+text
						}
					});
				}else{
					$.messager.alert('提示','合并了的表达式不能再修改表达式右侧'); 
				}
			}
		}
	}); 
}
/**
 * 表达式表格右键进行的双目逻辑操作
 * @param obj
 */
function doExpressLogic(obj){
	var rows = $("#dg2").datagrid("getSelections");
	if(rows.length!=2){
		$.messager.alert('提示','进行逻辑运算时必须且只能选择两行'); 
        return;
	}
	if(rows[0].data=='' || rows[1].data==''){
		$.messager.alert('提示','进行逻辑运算时选择的两行必须存在数据'); 
        return;
	}
    if(rows[0].type==0 && (rows[0].leftData=='' || rows[0].operate=='' || rows[0].rightData=='')){
    	$.messager.alert('提示','选中的第一行表达式数据不完整，不能保存'); 
        return;
    }
    if(rows[1].type==0 && (rows[1].leftData=='' || rows[1].operate=='' || rows[1].rightData=='')){
    	$.messager.alert('提示','选中的第二行表达式数据不完整，不能保存'); 
        return;
    }
	var rowIndex0 = $("#dg2").datagrid("getRowIndex",rows[0]);
	var rowIndex1 = $("#dg2").datagrid("getRowIndex",rows[1]);

	var item = $('#menuLogic').menu('getItem', obj);
	var data0 = rows[0].data;
	var data1 = rows[1].data;
	if(data0.substring(0,1)!="(" || data0.substring(data0.length-1)!=")"){
		data0 = "(\t"+data0+"\t)";
	}
	if(data1.substring(0,1)!="(" || data1.substring(data1.length-1)!=")"){
		data1 = "(\t"+data1+"\t)";
	}
	$('#dg2').datagrid('updateRow',{
		index: rowIndex0,
		row: {type:1,data:"(\t"+data0+"\t "+item.text+" \t"+data1+"\t)"}
	});
	$('#dg2').datagrid('deleteRow',rowIndex1);
}
/**
 * 将一个表达式添加至公式窗口
 */
function doAddToFormula(){
	var row = $("#dg2").datagrid("getSelected");
	if(row.type==0 && (row.leftData=='' || row.operate=='' || row.rightData=='')){
    	$.messager.alert('提示','选中的表达式数据不完整，不能添加至公式'); 
        return;
    }
	var data = row.data;
	data = data.replace(/\03/g,"\05").replace(/\t/g,"\04");
	$('#menuPpt').menu('appendItem',{
		iconCls:'icon-code',
		text:data,
		onclick:function(){
			doAddExpress(this);
		}
	})
	var rowIndex = $("#dg2").datagrid("getRowIndex",row);
	$('#dg2').datagrid('deleteRow',rowIndex);
}
/**
 * 表达式界面上一步
 */
function doPrevious2(){
	$('#w2').window('close'); 
	$('#w1').window('open'); 
}
