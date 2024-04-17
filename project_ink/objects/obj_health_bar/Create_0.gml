/// @description Insert description here
// You can write your code in this editor

width=40;
height=5;

left=x-(width>>1);
top=y-(height>>1);
right=left+width;
bottom=top+height;

maxHp=10;
hp=9;
hpPercentage=hp/maxHp;

target=pointer_null;
offsetx=0;
offsety=-25;

function setPosition(_x, _y){
	x=_x;
	y=_y;
	left=x-(width>>1);
	top=y-(height>>1);
	right=left+width;
	bottom=top+height;
}
function setWidth(w){
	width=w;
	left=x-(width>>1);
	right=left+width;
}
function setHeight(h){
	height=h;
	top=y-(height>>1);
	bottom=top+height;
}
function setMaxHp(h){
	maxHp=h;
	hpPercentage=hp/maxHp;
}
function setHp(h){
	hp=h;
	hpPercentage=hp/maxHp;
}
function initializeHealthBar(followingObject, max_hp){
	maxHp=max_hp;
	hp=maxHp;
	hpPercentage=hp/maxHp;
	target=followingObject;
}