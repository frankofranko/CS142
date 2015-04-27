function Tagger(parentDivId, feedbackDivId, xPosId, yPosId, widthId, heightId){
	
	this.parent_div = document.getElementById(parentDivId);
	this.feedback_div = document.getElementById(feedbackDivId);

	this.x_pos = document.getElementById(xPosId);
	this.y_pos = document.getElementById(yPosId);
	this.tag_width = document.getElementById(widthId);
	this.tag_height = document.getElementById(heightId);



    this.isMouseDown = false;

	var obj = this
	this.parent_div.onmousedown = function(event){
		obj.mouseDown(event);
	}

}


Tagger.prototype.mouseDown = function(event) {

	event.preventDefault();
	console.log("mousedown")


    var obj = this;

    this.oldMoveHandler = document.body.onmousemove;
    document.body.onmousemove = function(event) {
        obj.mouseMove(event);
    }
    this.oldUpHandler = document.body.onmouseup;
    document.body.onmouseup = function(event) {
        obj.mouseUp(event);
    }

    this.isMouseDown = true;

    this.ori_x = event.pageX;
    this.ori_y = event.pageY;

    // this.feedback_div.style
    this.feedback_div.style.width = "5px";
    this.feedback_div.style.height = "5px";

    var x_temp = event.pageX-this.parent_div.offsetLeft-this.parent_div.offsetParent.offsetLeft;
    var y_temp = event.pageY-this.parent_div.offsetTop-this.parent_div.offsetParent.offsetTop;

    this.feedback_div.style.left = x_temp + "px";
    this.feedback_div.style.top = y_temp + "px";

	    // console.log(this.parent_div.offsetParent.offsetLeft)
	    // console.log(event.pageX+"   "+this.parent_div.offsetLeft)
	    // console.log(event.pageY+"   "+this.parent_div.offsetTop)


    // this.oldX = event.pageX;
    // this.oldY = event.pageY;
    this.isMouseDown = true;
}


Tagger.prototype.mouseMove = function(event) {
    
    if (!this.isMouseDown) {
        return;
    }

    var width_temp = event.pageX-this.ori_x;
    var height_temp = event.pageY-this.ori_y;
    console.log(width_temp+"  "+this.feedback_div.offsetLeft+"  "+this.parent_div.clientWidth)
    if(width_temp>=0){
    	// console.log(width_temp+this.feedback_div.offsetLeft+"  "+this.parent_div.clientWidth)
    	// console.log(this.parent_div.width)
    	if(width_temp+this.feedback_div.offsetLeft>this.parent_div.clientWidth){width_temp=this.parent_div.clientWidth-this.feedback_div.offsetLeft;}
    	this.feedback_div.style.width = width_temp+"px";
    	console.log(width_temp)

    }
    else {
    	if(this.ori_x-this.parent_div.offsetLeft-this.parent_div.offsetParent.offsetLeft+width_temp<0){
    		this.feedback_div.style.left = "0px";
    		this.feedback_div.style.width = this.ori_x-this.parent_div.offsetLeft-this.parent_div.offsetParent.offsetLeft+"px";
    	}
    	else{
    		this.feedback_div.style.left = this.ori_x-this.parent_div.offsetLeft-this.parent_div.offsetParent.offsetLeft+width_temp+"px";
    		this.feedback_div.style.width = -width_temp+"px";
    	}
    }
	if(height_temp>=0){
    	if(height_temp+this.feedback_div.offsetTop>this.parent_div.clientHeight){height_temp=this.parent_div.clientHeight-this.feedback_div.offsetTop;}
    	this.feedback_div.style.height = height_temp+"px";
    }
    else {
    	if(this.ori_y-this.parent_div.offsetTop-this.parent_div.offsetParent.offsetTop+height_temp<0){
    		this.feedback_div.style.top = "0px";
    		this.feedback_div.style.height = this.ori_y-this.parent_div.offsetTop-this.parent_div.offsetParent.offsetTop+"px";
    	}
    	else{
    		this.feedback_div.style.top = this.ori_y-this.parent_div.offsetTop-this.parent_div.offsetParent.offsetTop+height_temp+"px";
    		this.feedback_div.style.height = -height_temp+"px";
    	}
    }
    // this.element.style.left = (this.element.offsetLeft
    //         + (event.clientX - this.oldX)) + "px";
    // this.element.style.top = (this.element.offsetTop
    //         + (event.clientY - this.oldY)) + "px";
    // this.oldX = event.clientX;
    // this.oldY = event.clientY;
    this.updateHiddenFields();

}


Tagger.prototype.mouseUp = function(event) {
    document.body.onmousemove = this.oldMoveHandler;
    document.body.onmouseup = this.oldUpHandler;
    this.isMouseDown = false;
}

Tagger.prototype.updateHiddenFields = function ()
{
    this.x_pos.value = this.feedback_div.offsetLeft;
    this.y_pos.value = this.feedback_div.offsetTop;
    console.log(this.feedback_div.offsetTop);
    this.tag_width.value = this.feedback_div.clientWidth;
    this.tag_height.value = this.feedback_div.clientHeight;
}

