function Cartoon(){
	this.name="cartoon";
	this.width=1;
	this.height=1;
	this.imgSrc=[];
	this.interval=5000;
	this.speed=4;
	this.count=0;
	this.setName=function(n){
		this.name=n;
	}
	this.setWidth=function(w){
		this.width=w;
	};
	this.setHeight=function(h){
		this.height=h;
	};
	this.setInterval=function(v){
		this.interval=v;
	};
	this.setSpeed=function(s){
		this.speed=s;
	};
	this.setImage=function(src){
		var srcArray = src.split("|");
		this.imgSrc=srcArray;
	};
	this.get=function(id){
		return document.getElementById(id);
	};
	this.leftX=function(){
		var m = this.get("mv").style.left;
		return m.replace("px","")-0;
	};
	this.show=function(){
		var html = "<div style='width:"+this.width+"px;overflow:hidden'>";
		html += "<div id='mv' style='position:relative;'>";
		html += "<table cellpadding=0 cellspacing=0 border=0><tr>";
		for(var i=0;i<this.imgSrc.length;i++){
			html += "<td><img id='img"+i+"' src='"+this.imgSrc[i]+"' height="+this.height+" width="+this.width+" /></td>";
		}
		html += "</tr></table>";
		html += "</div>";
		html += "</div>";
		document.write(html);
	};
	this.start=function(){
		var s = setInterval(this.name+".move()",10);
	};
	this.move=function(){
		this.count++;
		if(this.count*10<this.interval){
			return;
		}
		var left = this.leftX() - this.speed;
		this.get("mv").style.left = left + "px";
		if(left+this.width<0){
			var temp = this.imgSrc[0];
			for(var i=0;i<this.imgSrc.length-1;i++){
				this.imgSrc[i]=this.imgSrc[i+1];
			}
			this.imgSrc[this.imgSrc.length-1]=temp;
			for(var i=0;i<this.imgSrc.length;i++){
				this.get("img"+i).src=this.imgSrc[i];
			}
			this.count=0;
			this.get("mv").style.left = "0px";
		}
	}
}