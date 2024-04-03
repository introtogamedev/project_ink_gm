/// @description Insert description here
// You can write your code in this editor

stayPosY=y;
stayPosX=x;

//floating
floatAmount=100;
floatDir=0;
function float(){
	show_debug_message("floatDir="+string(floatDir)+", y="+string(y));
	if(floatDir==0){
		--y;
	}
	else{
		++y;
	}
	if(y>stayPosY+floatAmount){
		show_debug_message("too down");
		y=stayPosY+floatAmount;
		floatDir=0;
	}
	else if(y<stayPosY-floatAmount){
		show_debug_message("too up");
		y=stayPosY-floatAmount;
		floatDir=1;
	}
}
function setStayPosition(_x,_y){
	stayPosX=_x;
	stayPoxY=_y;
	x=_x;
	y=_y;
}