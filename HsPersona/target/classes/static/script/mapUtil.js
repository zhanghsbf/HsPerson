var widths,height;
var colorArr =['#cee6f0','#9fcde0','#5eabcc','#2c90bc','#00a2ca'];
/*dataInfo包含id，name,color */
function addMap(dataUrl,mapDiv,dataInfo) {
	// 注意：d3.json() 不能直接读取本地文件，因此你需要搭建一个服务器，例如 Apache。
	width = $('#'+mapDiv).width();
	height = $('#'+mapDiv).height();
	d3.json(dataUrl, function(error, root) {
		if (error){
			return console.error(error);
		}
		var projection = d3.geo.mercator()
		.center(getCenters(root.features))//center() 设定地图的中心位置，[107,31] 指的是经度和纬度。
		.scale(getZoomScale(root.features)*50)//scale() 设定放大的比例。
		.translate([width/2, height/2]);//translate() 设定平移。
		//为了根据地图的地理数据生成 SVG 中 path 元素的路径值，需要用到 d3.geo.path()，我称它为地理路径生成器。
		//projection() 是设定生成器的投影函数，把上面定义的投影传入即可。以后，当使用此生成器计算路径时，会自己加入投影的影响。
		var path = d3.geo.path().projection(projection);
		var color = d3.scale.category20();  
		var svg=d3.select("#"+mapDiv)
				.append("svg")
				.attr("width",width)
				.attr("height",height)
				.attr('style','background-color:#F3F3FA');
		var states = svg.append("svg:g").attr("id", "states");  
		var circles = svg.append("svg:g").attr("id", "circles");
		var texts = svg.append("svg:g").attr("id", "texts");  
		//地图信息
		states.selectAll("path")
		.data(root.features)
		.enter()
		.append("path")
		.attr("stroke","#000")
		.attr("stroke-width",1)
		.attr("fill", function(d,i){
			console.log(d.properties.id);
			return color(i);
		})
		.attr('font-size','14px')
		.attr("d", path)   //使用地理路径生成器
		.text(function(d,i){return d.properties.name;})
		.on("mouseover",function(d,i){
			d3.select(this).attr("fill","#FFF");
			d3.select(this).attr("stroke","red");
			d3.select(this).attr("stroke-width",2);
		})
		.on("mouseout",function(d,i){
			d3.select(this).attr("fill",color(i));
			d3.select(this).attr("stroke","#000");
			d3.select(this).attr("stroke-width",1);
		})
		.on("click",function(d,i){
		});
		var city={  
			"name": "地点",  
			"location":  [{
	            "name":"怀化市",  
	            "log":"109.9512", 
	            "lat":"27.4438",  
	            "img":"img/beijing.png"  
	        },  
	        {  
	            "name":"永州市",  
	            "log":"111.709",  
	            "lat":"25.752",  
	            "img":"img/shanghai.png"  
	        },  
	        {  
	            "name":"长沙市",  
	            "log":"113.0823",  
	            "lat":"28.2568",  
	            "img":"img/shanghai.png"  
	        },  
	        {  
	            "name":"株洲市",  
	            "log":"113.5327",  
	            "lat":"27.0319",  
	            "img":"img/shanghai.png"  
	        },  
	        {  
	            "name":"湘潭市",  
	            "log":"112.5439",  
	            "lat":"27.7075",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"张家界市",  
	            "log":"110.5115",  
	            "lat":"29.328",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"娄底市",  
	            "log":"111.6431",  
	            "lat":"27.7185",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"益阳市",  
	            "log":"111.731",  
	            "lat":"28.3832",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"岳阳市",  
	            "log":"113.2361",  
	            "lat":"29.1357",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"衡阳市",  
	            "log":"112.4121",  
	            "lat":"26.7902",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"湘西土家族苗族自治州",  
	            "log":"109.7864",  
	            "lat":"28.6743",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"常德市",  
	            "log":"111.4014",  
	            "lat":"29.2676",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"郴州市",  
	            "log":"113.2361",  
	            "lat":"25.8673",  
	            "img":"img/shanghai.png"  
	        } ,  
	        {  
	            "name":"邵阳市",  
	            "log":"110.9619",  
	            "lat":"26.8121",  
	            "img":"img/shanghai.png"  
	        }]}
		//点的信息
		circles
		.selectAll("path")//路径
		.data(city.location)  
        .enter()  
		.append("circle")//圆圈
	    .attr("class","point")  
	    .attr("transform",function(d){  
            //计算标注点的位置  
            var coor = projection([d.log, d.lat]);  
            return "translate("+ coor[0] + "," + coor[1] +")";  
        })  
	    .attr("r",5)
	    .text(function(d,i){return d.name;});
		//文字信息
		texts
		.selectAll("path")
		.data(city.location)
		.enter()  
		.append("text")//文字
	    .attr("class","texts") 
	    .attr("transform",function(d){  
            //计算标注点的位置  
           var coor = projection([d.log, d.lat]);  
	    	x = coor[0],
	    	y = coor[1];
	    	return "translate(" + x + ", " + y + ")";
        })  
	    .text(function(d,i){return d.name;})
	    .attr('font-size','14px');
		 //location.append("image")  图片信息
});
}

//获得地图的中心 获得center
function getCenters(features){
        var longitudeMin = 100000;//最小经度值
        var latitudeMin = 100000;//最小纬度值
        var longitudeMax = 0;//最大经度值
        var latitudeMax = 0;//最大纬度值
        features.forEach(function(e){  
            var a = d3.geo.bounds(e);//[为某个对象计算经纬度  d3.geo.bounds - compute the latitude-longitude bounding box for a given feature]
            if(a[0][0] < longitudeMin) {
                longitudeMin = a[0][0];
            }
            if(a[0][1] < latitudeMin) {
                latitudeMin = a[0][1];
            }
            if(a[1][0] > longitudeMax) {
                longitudeMax = a[1][0];
            }
            if(a[1][1] > latitudeMax) {
                latitudeMax = a[1][1];
            }
        });
     
        var a = (longitudeMax + longitudeMin)/2;
        var b = (latitudeMax + latitudeMin)/2;
     
        return [a, b];
    }
 
//设置地图的大小 获得 scale
function getZoomScale(features){
            var longitudeMin = 100000;//最小经度值
            var latitudeMin = 100000;//最小纬度值
            var longitudeMax = 0;//最大经度值
            var latitudeMax = 0;//最大纬度值
            features.forEach(function(e){  
                var a = d3.geo.bounds(e);//[为某个对象计算经纬度  d3.geo.bounds - compute the latitude-longitude bounding box for a given feature]
                if(a[0][0] < longitudeMin) {
                    longitudeMin = a[0][0];
                }
                if(a[0][1] < latitudeMin) {
                    latitudeMin = a[0][1];
                }
                if(a[1][0] > longitudeMax) {
                    longitudeMax = a[1][0];
                }
                if(a[1][1] > latitudeMax) {
                    latitudeMax = a[1][1];
                }
            });
         
            var a = longitudeMax-longitudeMin;
            var b = latitudeMax-latitudeMin;
            return (width/a)>(height/b)?height/b:width/a;
        }
