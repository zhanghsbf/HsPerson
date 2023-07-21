D3c=function(){
	this.version='1.2';
}
D3c.Chart=function(){
	this.margin=[90,90,90,90];//sxzy
	this.bgColor="#F9F9F9";
	this.foreColor="#1F77B4";
	this.blankColor="#FFFFFF";
	this.color10=d3.scale.category10();
	this.color20=d3.scale.category20();
	this.color=function(i){
		if(i<=10){
			return this.color10(i);
		}else if(i<=30){
			return this.color20(i-10)
		}
	}
	this.svg=function(v){
		if (v.target){
			return d3.select("#"+v.target)
				.append("svg")
				.attr("width",v.width)
				.attr("height",v.height)
				.attr('style','background-color:'+v.bgColor);
		}else{		
			return d3.select("body")
				.append("svg")
				.attr("width",v.width)
				.attr("height",v.height)
				.attr('style','background-color:'+v.bgColor);
		}
	}
	this.scale=function(x,y1,y2,v){
		var dx=d3.scale.linear()
			.domain([0,x])
			.range([v.margin[2],v.width-v.margin[3]]);
		var dy=d3.scale.linear()
			.domain([y1,y2])
			.range([-v.margin[1],-(v.height-v.margin[0])]);
		return [dx,dy];
	}
	this.text=function(v){
		var s="font-size:"+v.font[0]+";font-family:"+v.font[1]+";text-anchor:"+v.font[2]+";"
		var t=v.svg.append("g")
			.append("text")
			.attr("transform", v.transform)
			//.attr("style",s)
			.attr("x",v.xy[0])
			.attr("y",v.xy[1])
			.text(v.text);
		if(v.id){
			t.attr("id",v.id);
		}
		if(v.font[0]){
			t.style("font-size",v.font[0]);
		}
		if(v.font[1]){
			t.style("font-family",v.font[1]);
		}
		if(v.font[2]){
			t.style("text-anchor",v.font[2]);
		}
		if(v.font[3]){
			t.style("fill",v.font[3]);
		}
	}
	this.title=function(s,t,h,w){
		if(t.text){
			this.text({
				svg:s,
				text:t.text,
				font:[t.size,t.family,"middle"],
				xy:[w/2,t.dev]
			});
		}
		if(t.subText){
			this.text({
				svg:s,
				text:t.subText,
				font:[t.subSize,t.subFamily,"middle"],
				xy:[w/2,t.dev+t.height]
			});
		}
	}
	this.tip=function(s,x,y,txt,t,id1,id2){
		var w=(txt+"").length*(t.fontSize-1);
		w=(w<30)?30:w;
		s.append('path')
			.attr("id",id1)
			.attr( 'd', 'M5,0 L'+(w-5)+',0 C'+w+' 2,'+(w-2)+' 0,'+w+' 5 L'+w+',25 C'+(w-2)+' 30,'+w+' 28,'+(w-5)+' 30 L'+(w/2+5)+',30 L'+(w/2)+',35 L'+(w/2-5)+',30 L5,30,C0 28,2 30,0 25 L0,5 C2 0,0 2,5 0' )
			.attr("transform","translate("+(x-w/2)+","+(y-30-15)+")");
		this.text({
			id:id2,
			svg:s,
			text:txt,
			font:[t.fontSize,t.fontFamily,"middle","white"],
			xy:[x,y-25]
		});
	}
	this.legend=function(s,w,h,m,l){
		var marksY = (h+m[0]-m[1]-20*l.data.length)/2;
		var t=this;
		s.append("g").selectAll("rect")
			.data(l.data)
			.enter()
			.append('rect')
			.attr('x',function(d,i){
				t.text({
					svg:s,
					text:d,
					font:[l.fontSize,l.fontFamily,"start"],
					xy:[w-m[3]+55,marksY+20*i+10]
				});
				return w-m[3]+40;
			})
			.attr('y',function(d,i){return marksY+20*i;})
			.attr('height',10)
			.attr('width', 10)
			.attr("fill",function(d,i){return t.color(i);})
			.style("stroke",function(d,i){return t.color(i);})
	}
	this.add=function(d){
		var l=0,s=0;
		for(i in d){
			var p=d[i].toString().split(".");
			l=(p.length>1&&p[1].length>l)?p[1].length:l;
		}
		for(i in d){
			s+=d[i]*Math.pow(10,l);
		}
		return s/Math.pow(10,l)
	}
}
D3c.Chart.Axis=function(v){
	var xAxis = d3.svg.axis()
		.scale(v.scale[0])
		.orient('bottom')
		.ticks(v.axis.ticksX)
		.tickFormat(v.format[0]);
	var yAxis = d3.svg.axis()
		.scale(v.scale[1])
		.orient('left')
		.ticks(v.axis.ticksY)
		.tickFormat(v.format[1]);
	var gx=v.svg.append("g")
		.attr("transform","translate(0,"+(v.height-v.margin[1])+")")
		.call(xAxis);
	var gy=v.svg.append("g")
		.attr("transform","translate("+v.margin[2]+","+v.height+")")
		.call(yAxis);
	gx.selectAll("path")
		.attr("style","fill:none;stroke:black;shape-rendering:crispEdges;");
	gy.selectAll("path")
		.attr("style","fill:none;stroke:black;shape-rendering:crispEdges;");
	gx.selectAll("line")
		.attr("style","fill:none;stroke:black;shape-rendering:crispEdges;");
	gy.selectAll("line")
		.attr("style","fill:none;stroke:black;shape-rendering:crispEdges;");
	gx.selectAll("text")
		.attr("style","font-family:"+v.axis.fontFamily+";font-size:"+v.axis.fontSize+";text-anchor:"+v.axis.fontAlign+";")
		.attr("transform","translate("+(v.axis.dev?v.axis.dev:0)+","+2+"),rotate("+(v.axis.rotate?v.axis.rotate:0)+",0,0)");
	gy.selectAll("text")
		.attr("style","font-family:"+v.axis.fontFamily+";font-size:"+v.axis.fontSize+";text-anchor:end;");
	var chart=new D3c.Chart();
	chart.text({
		svg:v.svg,
		text:v.axis.label[0],
		font:[v.axis.fontSize,v.axis.fontFamily,"start"],
		xy:[v.width-v.margin[3],v.height-v.margin[1]+20]
	});
	chart.text({
		svg:v.svg,
		text:v.axis.label[1],
		font:[v.axis.fontSize,v.axis.fontFamily,"middle"],
		xy:[v.margin[2],v.margin[0]-10]
	});
	if(v.axis.grid==1 || v.axis.grid==3){
		var ggx=v.svg.append("g")
			.attr("transform","translate("+v.margin[2]+","+v.height+")")
			.call(yAxis.tickSize(-(v.width-v.margin[2]-v.margin[3]), 0, 0).tickFormat(""));
		ggx.selectAll("line")
			.filter(function(d){return d>0})
			.attr("style","stroke:#BBB;stroke-dasharray:2,2;shape-rendering:crispEdges;");
	}
	if(v.axis.grid==2 || v.axis.grid==3){
		var ggy=v.svg.append("g")
			.attr("transform","translate(0,"+(v.height-v.margin[1])+")")
			.call(xAxis.tickSize(-(v.height-v.margin[0]-v.margin[1]), 0, 0).tickFormat(""));
		ggy.selectAll("line")
			.filter(function(d){return d>0})
			.attr("style","stroke:#BBB;stroke-dasharray:2,2;shape-rendering:crispEdges;");
	}
}
D3c.Chart.Bar=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksX=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxX=v.data.length+1,maxY = 0;
	v.data.forEach(function(d){maxY=(maxY<d[1])?d[1]:maxY});
	var scale = chart.scale(maxX,0,maxY,v);
	//画坐标轴
	var fmtX=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	var fmtY=function(d){return d;};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画柱
	var barWidth = ((v.width-v.margin[2]-v.margin[3])/(v.data.length+1))*v.barWidth;
	svg.selectAll("rect")
		.data(v.data)
		.enter()
		.append('rect')
		.attr('x', function(d,i) {return scale[0](i+1)-barWidth/2;})
		.attr('y',v.height-v.margin[1])
		.attr('height', 0)
		.attr('width', barWidth)
		.attr('fill',function(d,i){return v.barColor?v.barColor:(chart.color(i))})
		.on('mouseenter',function(d,i){
			this.setAttribute("stroke",v.barColor?v.barColor:chart.color(i));
			this.setAttribute("fill","#FFFFFF");
			this.setAttribute("stroke-width","2");
		})
		.on('mouseout',function(d,i){
			this.setAttribute("stroke","");
			this.setAttribute("fill",v.barColor?v.barColor:chart.color(i));
			this.setAttribute("stroke-width","0");
		})
		.transition()
		.duration(1000)
		.attr('height', function(d){return -v.margin[1]-scale[1](d[1]);})
		.attr('y',function(d){return v.height+scale[1](d[1]);})
		.each('end',function(d,i){
			if(v.tips){
				var x=scale[0](i+1)+(v.tips.dev?v.tips.dev:0),y=v.height+scale[1](d[1])-4;
				chart.text({
					svg:svg,
					text:d[1],
					font:[v.tips.fontSize,v.tips.fontFamily,v.tips.fontAlign],
					transform:"rotate("+((v.tips&&v.tips.rotate)?v.tips.rotate:0)+","+x+","+y+")",
					xy:[x,y]
				});
			}
		})
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	return v;
}
D3c.Chart.HorizontalBar=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksY=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxY=v.data.length+1,maxX = 0;
	v.data.forEach(function(d){maxX=(maxX<d[1])?d[1]:maxX});
	var scale = chart.scale(maxX,0,maxY,v);
	//画坐标轴
	var fmtX=function(d){return d;};
	var fmtY=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画柱
	var barWidth = ((v.height-v.margin[0]-v.margin[1])/(v.data.length+1))*v.barWidth;
	svg.selectAll("rect")
		.data(v.data)
		.enter()
		.append('rect')
		.attr('x',v.margin[2])
		.attr('y',function(d,i){return v.height+scale[1](i+1)-barWidth/2})
		.attr('height', barWidth)
		.attr('width', 0)
		.attr('fill',function(d,i){return v.barColor?v.barColor:chart.color(i)})
		.on('mouseenter',function(d,i){
			d3.selectAll("#tipsrect").remove();
			svg.append('rect')
				.attr('id','tipsrect')
				.attr('x', function(d) {return v.margin[2];})
				.attr('y',v.height+scale[1](i+1)-barWidth/2)
				.attr('height', barWidth)
				.attr('width', scale[0](d[1])-v.margin[2])
				.attr('fill',"#FFFFFF")
				.style("stroke",v.barColor?v.barColor:chart.color(i))
				.style("stroke-width",2)
				.on('mouseout',function(d){
					d3.selectAll("#tipsrect").remove();
				})
		})
		.transition()
		.duration(1000)
		.attr('width', function(d){return scale[0](d[1])-v.margin[2];})
		.each('end',function(d,i){
			if(v.tips){
				var x=scale[0](d[1])+4,y=v.height+scale[1](i+1)+4;
				chart.text({
					svg:svg,
					text:d[1],
					font:[v.tips.fontSize,v.tips.fontFamily,v.tips.fontAlign],
					xy:[x,y]
				});
			}
		})
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	return v;
}
D3c.Chart.StackBar=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.margin[3]=v.margin[3]+(v.legend?100:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksX=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxX=v.data.length+1,maxY = 0,mData=[];
	v.data.forEach(function(d,i){
		var sum=0;
		for(var j=1;j<d.length;j++){
			sum=chart.add([sum,d[j]]);
			mData[mData.length]=[i,d[j],sum]
		}
		maxY=(maxY<sum)?sum:maxY
	})
	var scale = chart.scale(maxX,0,maxY,v);
	//画坐标轴
	var fmtX=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	var fmtY=function(d){return d;};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画柱
	var barWidth = ((v.width-v.margin[2]-v.margin[3])/(v.data.length+1))*v.barWidth;
	svg.selectAll("rect")
		.data(mData)
		.enter()
		.append('rect')
		.attr('x',function(d){return scale[0](d[0]+1)-barWidth/2;})
		.attr('y',v.height-v.margin[1])
		.attr('height',0)
		.attr('width', barWidth)
		.attr('fill',function(d,i){return chart.color(i%(v.data[0].length-1))})
		.on('mouseenter',function(d,i){
			d3.selectAll("#tipstxt").remove();
			d3.selectAll("#tipswin").remove();
			this.setAttribute("stroke",chart.color(i%(v.data[0].length-1)));
			this.setAttribute("fill","#FFFFFF");
			this.setAttribute("stroke-width","2");
			var cx=scale[0](d[0]+1),cy=v.height+scale[1](d[2]);
			chart.tip(svg,cx,cy,d[1],v.tips,"tipswin","tipstxt");
		})
		.on('mouseout',function(d,i){
			this.setAttribute("stroke","");
			this.setAttribute("fill",chart.color(i%(v.data[0].length-1)));
			this.setAttribute("stroke-width","0");
			d3.selectAll("#tipstxt").remove();
			d3.selectAll("#tipswin").remove();
		})
		.transition()
		.duration(1000)
		.attr('height', function(d){return -v.margin[1]-scale[1](d[1])})
		.attr('y',function(d){return v.height+scale[1](d[2])})
		.each('end',function(d,i){
			if(v.tips){
				if(i%(v.data[0].length-1)==v.data[0].length-2){
					var x=scale[0](d[0]+1)+(v.tips.dev?v.tips.dev:0),y=v.height+scale[1](d[2])-4;
					chart.text({
						svg:svg,
						text:d[2],
						font:[v.tips.fontSize,v.tips.fontFamily,v.tips.fontAlign],
						transform:"rotate("+((v.tips&&v.tips.rotate)?v.tips.rotate:0)+","+x+","+y+")",
						xy:[x,y]
					});
				}
			}
		})
	//画legend
	if(v.legend){
		chart.legend(svg,v.width,v.height,v.margin,v.legend);
	}
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	return v;
}
D3c.Chart.NormalizedStackBar=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.margin[3]=v.margin[3]+(v.legend?100:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksX=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxX=v.data.length+1,mData=[];
	v.data.forEach(function(d,i){
		var sum=0;
		for(var j=1;j<d.length;j++){
			sum=chart.add([sum,d[j]]);
			mData[mData.length]=[i,d[j],sum]
		}
		for(var j=1;j<d.length;j++){
			mData[mData.length-d.length+j][3]=sum;
		}
	})
	var scale = chart.scale(maxX,0,1,v);
	//画坐标轴
	var fmtX=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	var fmtY=function(d){return d*100+'%';};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画柱
	var barWidth = ((v.width-v.margin[2]-v.margin[3])/(v.data.length+1))*v.barWidth;
	svg.selectAll("rect")
		.data(mData)
		.enter()
		.append('rect')
		.attr('x',function(d){return scale[0](d[0]+1)-barWidth/2;})
		.attr('y',v.height-v.margin[1])
		.attr('height',0)
		.attr('width', barWidth)
		.attr('fill',function(d,i){return chart.color(i%(v.data[0].length-1))})
		.on('mouseenter',function(d,i){
			d3.selectAll("#tipstxt").remove();
			d3.selectAll("#tipswin").remove();
			this.setAttribute("stroke",chart.color(i%(v.data[0].length-1)));
			this.setAttribute("fill","#FFFFFF");
			this.setAttribute("stroke-width","2");
			var cx=scale[0](d[0]+1),cy=v.height+scale[1](d[2]/d[3]);
			var txt = d[1]+','+(d[1]*100/d[3]).toFixed(2)+'%';
			chart.tip(svg,cx,cy,txt,v.tips,"tipswin","tipstxt");
		})
		.on('mouseout',function(d,i){
			this.setAttribute("stroke","");
			this.setAttribute("fill",chart.color(i%(v.data[0].length-1)));
			this.setAttribute("stroke-width","0");
			d3.selectAll("#tipstxt").remove();
			d3.selectAll("#tipswin").remove();
		})
		.transition()
		.duration(1000)
		.attr('height', function(d){return -v.margin[1]-scale[1](d[1]/d[3])})
		.attr('y',function(d){return v.height+scale[1](d[2]/d[3])})
	//画legend
	if(v.legend){
		chart.legend(svg,v.width,v.height,v.margin,v.legend);
	}
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	return v;
}
D3c.Chart.GroupBar=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.margin[3]=v.margin[3]+(v.legend?100:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksX=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxX=v.data.length+1,maxY = 0,mData=[];
	v.data.forEach(function(d,i){
		var sx=-(d.length-1)/2;
		for(var j=1;j<d.length;j++){
			mData[mData.length]=[i,d[j],sx+(j-1)];
			maxY=(maxY<d[j])?d[j]:maxY
		}
	})
	var scale = chart.scale(maxX,0,maxY,v);
	//画坐标轴
	var fmtX=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	var fmtY=function(d){return d;};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画柱
	var barWidth = ((v.width-v.margin[2]-v.margin[3])/(v.data.length+1))*v.barWidth/(v.data[0].length-1);
	svg.selectAll("rect")
		.data(mData)
		.enter()
		.append('rect')
		.attr('x', function(d) {return scale[0](d[0]+1)+barWidth*d[2]+d[2]*2;})
		.attr('y',v.height-v.margin[1])
		.attr('height',0)
		.attr('width', barWidth)
		.attr('fill',function(d,i){return chart.color(i%(v.data[0].length-1))})
		.on('mouseenter',function(d,i){
			this.setAttribute("stroke",chart.color(i%(v.data[0].length-1)));
			this.setAttribute("fill","#FFFFFF");
			this.setAttribute("stroke-width","2");
		})
		.on('mouseout',function(d,i){
			this.setAttribute("stroke","");
			this.setAttribute("fill",chart.color(i%(v.data[0].length-1)));
			this.setAttribute("stroke-width","0");
		})
		.transition()
		.duration(1000)
		.attr('height', function(d){return -v.margin[1]-scale[1](d[1]);})
		.attr('y',function(d){return v.height+scale[1](d[1]);})
		.each('end',function(d,i){
			if(v.tips){
				var x=scale[0](d[0]+1)+barWidth*d[2]+(v.tips.dev?v.tips.dev:0),y=v.height+scale[1](d[1])-4;
				chart.text({
					svg:svg,
					text:d[1],
					font:[v.tips.fontSize,v.tips.fontFamily,v.tips.fontAlign],
					transform:"rotate("+((v.tips&&v.tips.rotate)?v.tips.rotate:0)+","+x+","+y+")",
					xy:[x,y]
				});
			}
		})
	//画legend
	if(v.legend){
		chart.legend(svg,v.width,v.height,v.margin,v.legend);
	}
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
}
D3c.Chart.Line=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksX=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxX=v.data.length+1,maxY = 0,minY=0;
	v.data.forEach(function(d){maxY=(maxY<d[1])?d[1]:maxY});
	if(v.fromMin){
		minY = maxY;
		v.data.forEach(function(d){minY=(minY>d[1])?d[1]:minY});
	}
	var scale = chart.scale(maxX,minY,maxY,v);
	//画坐标轴
	var fmtX=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	var fmtY=function(d){return d;};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画线
	var value = d3.svg.line()
		.x(function(d,i){return scale[0](i+1);})
		.y(function(d){return v.height+scale[1](d[1]);});
	svg.append("path")  
		.style("stroke",v.bgColor)
		.transition()
		.duration(2000)
		.style("stroke",chart.foreColor)
		.style("stroke-width",v.lineWidth)
		.style("fill","none")
		.attr("d",value(v.data))
	//画tips
	if(v.tips){
		var in1=false,in2=true,i=0;
		svg.selectAll("circle")
			.data(v.data)
			.enter()
			.append("circle")
			.style("stroke","white")
			.style("fill",chart.foreColor)
			.style("stroke-width",v.lineWidth+2)
			.attr('r',0)
			.attr('cx',function(d,i){return scale[0](i+1)})
			.attr('cy',function(d){return v.height+scale[1](d[1])})
			.on('mouseover', function(d,i){
				d3.selectAll("#tipswin").remove();
				d3.selectAll("#tipstxt").remove();
				d3.selectAll("#tipsid").remove();
				var cx=scale[0](i+1),cy=v.height+scale[1](d[1]);
				svg.append("circle")
					.attr("id","tipsid")
					.style("stroke",chart.foreColor)
					.style("fill","white")
					.style("stroke-width",v.lineWidth+2)
					.attr('r',v.lineWidth+4)
					.attr('cx',cx)
					.attr('cy',cy)
					.on('mouseout', function(d,i){
						d3.selectAll("#tipswin").remove();
						d3.selectAll("#tipstxt").remove();
						d3.selectAll("#tipsid").remove();
					})
				chart.tip(svg,cx,cy,d[1],v.tips,"tipswin","tipstxt");
			})
			.transition()
			.duration(1000)
			.delay(function(d,i){
				return i*100;
			})
			.attr('r',v.lineWidth+4);
	}
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	return v;
}
D3c.Chart.D3MultiLine=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.margin[3]=v.margin[3]+(v.legend?100:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.axis.ticksX=v.data.length+1;
	//画画布
	var svg=chart.svg(v);
	//计算比例尺
	var maxX=v.data.length+1,maxY = 0,minY=0;
	v.data.forEach(function(d){
		for(var i=1;i<d.length;i++){
			maxY=(maxY<d[i])?d[i]:maxY;
		}
	});
	if(v.fromMin){
		minY = maxY;
		v.data.forEach(function(d){
			for(var i=1;i<d.length;i++){
				minY=(minY>d[i])?d[i]:minY;
			}
		});
	}
	var scale = chart.scale(maxX,minY,maxY,v);
	//画坐标轴
	var fmtX=function(d){return (v.data[d-1])?v.data[d-1][0]:"";};
	var fmtY=function(d){return Math.round(d*Math.pow(10,12))/Math.pow(10,12);};
	new D3c.Chart.Axis({
		svg:svg,
		scale:scale,
		format:[fmtX,fmtY],
		axis:v.axis,
		height:v.height,
		width:v.width,
		margin:v.margin
	});
	//画线
	for(var j=1;j<v.data[0].length;j++){
		var value = d3.svg.line()
			.x(function(d,i){return scale[0](i+1);})
			.y(function(d){return v.height+scale[1](d[j]);});
		svg.append("path")
			.style("stroke",chart.bgColor)
			.transition()
			.duration(2000)
			.style("stroke",chart.color(j-1))
			.style("stroke-width",v.lineWidth)
			.style("fill","none")
			.attr("d",value(v.data))
	}
	//画tips
	if(v.tips){
		var mData=[];
		v.data.forEach(function(d,i){
			for(var j=1;j<d.length;j++){
				mData[mData.length]=[i,d[j],j]
			}
		})
		var in1=false,in2=true;
		svg.selectAll("circle")
			.data(mData)
			.enter()
			.append("circle")
			.style("stroke","white")
			.style("fill",function(d,i){return chart.color(d[2]-1);})
			.style("stroke-width",v.lineWidth+2)
			.attr('r',0)
			.attr('cx',function(d,i){return scale[0](d[0]+1)})
			.attr('cy',function(d){return v.height+scale[1](d[1])})			
			.on('mouseover',function(d,i){
				this.style.fill="#FFFFFF";
				this.style.stroke=chart.color(d[2]-1);
				var cx=scale[0](d[0]+1),cy=v.height+scale[1](d[1]);
				chart.tip(svg,cx,cy,d[1],v.tips,"tipswin","tipstxt");
				//this.setAttribute("stroke-width","2");
			})
			.on('mouseout',function(d,i){
				this.style.stroke="#FFFFFF";
				this.style.fill=chart.color(d[2]-1);
				d3.selectAll("#tipswin").remove();
				d3.selectAll("#tipstxt").remove();
			})
			.transition()
			.duration(1000)
			.delay(function(d,i){
				return d[0]*100;
			})
			.attr('r',v.lineWidth+4);
	}
	//画legend
	if(v.legend){
		chart.legend(svg,v.width,v.height,v.margin,v.legend);
	}
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	return v;
}
D3c.Chart.Pie=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.margin[3]=v.margin[3]+100;
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.innerRadius=(v.innerRadius)?v.innerRadius:0;
	v.outerRadius=(v.outerRadius)?v.outerRadius:((v.height>v.width)?v.width:v.height/3);
	//画画布
	var svg=chart.svg(v);
	//画饼
	var pie = d3.layout.pie().value(function(d) { return d[1]; })(v.data);
	var arc = d3.svg.arc()
		.innerRadius(v.innerRadius)
		.outerRadius(v.outerRadius); 
	var arc_m = d3.svg.arc()
		.innerRadius(v.innerRadius)
		.outerRadius(v.outerRadius+4); 
	var ox=v.margin[2]+(v.width-v.margin[2]-v.margin[3])/2,oy=v.margin[0]+42+((v.height-v.margin[0]-v.margin[1]-42)/2);
	var arcs = svg.selectAll("g")
		.data(pie)
		.enter()
		.append("g")
		.attr("transform","translate("+ ox +","+ oy +")")
		.append("path")
		.attr("fill",function(d,i){return chart.color(i);})
		.on('mouseenter',function(d,i){
			this.setAttribute("stroke","#FFFFFF");
			this.setAttribute("stroke-width","2");
			this.setAttribute("d",arc_m(d));
		})
		.on('mouseout',function(d,i){
			this.setAttribute("stroke","");
			this.setAttribute("stroke-width","0");
			this.setAttribute("d",arc(d));
		})
		.transition()
		.duration(1000)
		.attrTween('d',function(d) {
			return function(t){
				var f = d3.interpolate({startAngle:0,endAngle:0},d);
				return arc(f(t));
			};
		})
		.each('end',function(d,i){
			var coord=arc.centroid(pie[i]);
			chart.text({
				svg:svg,
				text:d.value,
				font:[v.tips.fontSize,v.tips.fontFamily,"middle"],
				xy:[(ox+coord[0]),(oy+coord[1])]
			});
		})
	//画legend
	if(v.legend){
		var legendData=[];
		v.data.forEach(function(d){legendData[legendData.length]=d[0]});
		v.legend.data=legendData;
		chart.legend(svg,v.width,v.height,v.margin,v.legend);
	}
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
}
D3c.Chart.Radar=function(v){
	var chart=new D3c.Chart();
	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.margin[3]=v.margin[3]+(v.legend?100:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	v.lineColor=v.lineColor?v.lineColor:chart.foreColor;
	//画画布
	var svg=chart.svg(v);
	//计算数据
	var maxX=0,radius=(v.height>v.width)?v.width:v.height/3;
	v.data.forEach(function(d){maxX=(maxX<d[1])?d[1]:maxX});
	//画图
	var ox=v.margin[2]+(v.width-v.margin[2]-v.margin[3])/2,oy=v.margin[0]+42+((v.height-v.margin[0]-v.margin[1]-42)/2);
	[0,0,0,0,0].forEach(function(d,i){
		svg.append("circle")
			.attr("r",radius*(i+1)/5)
			.attr("cx",ox)
			.attr("cy",oy)
			.style("stroke", "#CCC")
			.style("fill", "none");
		chart.text({
			svg:svg,
			text:(i+1)*maxX/5,
			font:[v.tips.fontSize,v.tips.fontFamily,"middle"],
			xy:genXY((i+1)*maxX/5,0)
		});
	})
	var path1="",v1=[],v2=[];
	v.data.forEach(function(d,i){
		var xy1=genXY(maxX,i);
		path1=path1+"M"+ox+","+oy+"L"+xy1[0]+","+xy1[1];
		v1[v1.length]=d;
		v2[v2.length]=['',0];
		if(i==v.data.length-1){
			v1[v1.length]=v.data[0];
			v2[v2.length]=['',0];
		}
		var align=(xy1[0]==ox)?"middle":(xy1[0]>ox?'start':'end')
		var mx=20*(xy1[0]-ox)/radius,my=20*(xy1[1]-oy)/radius;
		my=my+((xy1[1]>oy)?v.tips.fontSize:0);
		chart.text({
			svg:svg,
			text:d[0],
			font:[v.tips.fontSize,v.tips.fontFamily,align],
			transform:"translate(" +xy1[0]+","+xy1[1] + ")",
			xy:[mx,my]
		});
	})
	svg.append("path")
		.style("stroke","#CCC")
		.style("stroke-width",1)
		.style("fill","none")
		.attr("d",path1);
	var line = d3.svg.line()
		.x(function(d,i){return genXY(d[1],i)[0];})
		.y(function(d,i){return genXY(d[1],i)[1];});
	svg.append("path")
		.style("stroke",v.lineColor)
		.style("stroke-width",3)
		.style("fill",v.fillColor)
		.style("opacity",0.8)
		.attr("d",line(v2))
		.transition()
		.duration(1000)
		.attr("d",line(v1))
	v.data.forEach(function(d,i){
		var xy2=genXY(d[1],i);
		svg.append("circle")
			.attr("r",5)
			.attr("cx",xy2[0])
			.attr("cy",xy2[1])
			.style("stroke","#FFFFFF")
			.style("fill",v.lineColor)
			.style("stroke-width",3)
			.on('mouseover', function(dd,i){
				d3.selectAll("#tipswin").remove();
				d3.selectAll("#tipstxt").remove();
				d3.selectAll("#tipsid").remove();
				this.setAttribute("style","stroke:"+v.lineColor+";fill:#FFFFFF;stroke-width: 3px;");
				chart.tip(svg,xy2[0],xy2[1],d[1],v.tips,"tipswin","tipstxt");
			})
			.on('mouseout', function(d,i){
				d3.selectAll("#tipswin").remove();
				d3.selectAll("#tipstxt").remove();
				d3.selectAll("#tipsid").remove();
				this.setAttribute("style","stroke:#FFFFFF;fill:"+v.lineColor+";stroke-width: 3px;");
			})
	});
	//画标题
	if(v.title){
		chart.title(svg,v.title,v.height,v.width,v.margin);
	}
	function genXY(value,index){
		value=value*radius/maxX;
		var angle=index*Math.PI*2/v.data.length+Math.PI/2;
		return [ox+value*Math.cos(angle),oy-value*Math.sin(angle)];
	}
}
/*云词*/
D3c.Chart.Cloud = function(v,callback){
	var chart=new D3c.Chart();

	//参数填充
	v.margin=(v.margin)?v.margin:chart.margin;
	for(i in [0,1,2,3]){
		v.margin[i]=(v.margin[i])?v.margin[i]:chart.margin[i];
	}
	v.margin[0]=v.margin[0]+((v.title&&v.title.height)?v.title.height:0)+((v.title&&v.title.subHeight)?v.title.subHeight:0);
	v.bgColor=v.bgColor?v.bgColor:chart.bgColor;
	var cloud = d3.layout.cloud()
	    .size([v.width, v.height])
	    .words(v.data)
	    .padding(2)
	    .rotate(function(d){return d.rotate;})
	    .font("Impact")
	    .fontSize(function(d){return d.size;});
	//画图
	var svg=chart.svg(v);
	cloud.on("end", function(words){
		svg.attr("width", cloud.size()[0])
			.attr("height", cloud.size()[1])
			.append("g")
			.attr("transform", "translate(" + cloud.size()[0] / 2 + "," + cloud.size()[1] / 2 + ")")
			.selectAll("text")
			.data(words)
			.enter().append("text")
			.style("font-size", function(d) {return d.size + "px"; })
			.style("font-family", 'Microsoft YaHei')
			.style("fill", function(d, i) { return chart.color(i); })
			.attr("text-anchor", "middle")
			.attr("transform", function(d) {
				return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
			})
			.text(function(d) { return d.text; })
			.on('mouseenter',function(d,i){
				this.setAttribute("stroke","");
				this.setAttribute("stroke-width","2");
				this.setAttribute("font-weight","bold");
				this.setAttribute("cursor","pointer");
			})
			.on('mouseout',function(d,i){
				this.setAttribute("stroke","");
				this.setAttribute("stroke-width","0");
				this.setAttribute("font-weight","");
				this.setAttribute("cursor","");
			})
			.on('click',function(d,i){
				
				callback.call(this,d);
				//点击事件
			});
	});
	cloud.start();
}