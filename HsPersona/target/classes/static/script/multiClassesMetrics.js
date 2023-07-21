function showTagPie(data,width){
	var data1 = [],data2=[];
	for(var i=0;i<data.length;i++){
		data1[data1.length] = [data[i][0],data[i][1]];
		data2[data2.length] = [data[i][0],data[i][2]];
	}
	var pie1 = new D3c.Chart.Pie({
		data:data1,
		target:'tag1',
		width:width*0.4,
		height:350,
		margin:[,,50,10],
		outerRadius:100,
		innerRadius:30,
		bgColor:'#FFFFFF',
		title:{
			dev:40,
			text:"训练数据集各结果值占比　　　　",
			family:'Microsoft YaHei',
			size:20
		},
		tips:{
			fontFamily:'Verdana',
			fontSize:10,
			fontAlign:'start',
			rotate:-90,
			dev:5
		}
	});
	var pie2 = new D3c.Chart.Pie({
		data:data,
		target:'tag2',
		width:width*0.6,
		height:350,
		outerRadius:100,
		innerRadius:30,
		bgColor:'#FFFFFF',
		title:{
			dev:40,
			text:"测试数据集各结果值占比　　",
			family:'Microsoft YaHei',
			size:20
		},
		legend:{
			fontSize:11,
			fontFamily:"Microsoft YaHei"
		},
		tips:{
			fontFamily:'Verdana',
			fontSize:10,
			fontAlign:'start',
			rotate:-90,
			dev:5
		}
	});
}
function showLine(id,width,legend,data,title,xlabel,ylabel){
	for(var i=0;i<data.length;i++){
		for(var j=1;j<data[0].length;j++){
			data[i][j]=Math.round(data[i][j]*100)/100;
		}
	}
	var line = new D3c.Chart.D3MultiLine({
		data:data,
		target:id,
		width:width,
		height:350,
		lineWidth:1,
		fromMin:true,
		bgColor:'#FFFFFF',
		title:{
			dev:40,
			text:title,
			family:'Microsoft YaHei',
			size:20,
		},
		tips:{
			fontFamily:'Verdana',
			fontSize:10,
			fontAlign:'start',
			rotate:-90,
			dev:5
		},
		legend:{
			data:legend,
			fontSize:11,
			fontFamily:"Microsoft YaHei"
		},
		axis:{
			label:[xlabel,ylabel],
			fontSize:11,
			fontFamily:"Microsoft YaHei",
			fontAlign:'end',
			grid:3,
		rotate:-60,
		dev:-8
		},
	});
}