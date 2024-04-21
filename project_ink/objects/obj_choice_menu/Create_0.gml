/// @description Insert description here
// You can write your code in this editor

//draw
middlex=700;
topy=50;
spacingx=30;
width=124;
height=182;
card_x=middlex-(width>>1)-width-spacingx;
card_y=topy+250;
card_y_bottom=card_y+height;

card_xes=array_create(3);
card_xes[0]=card_x;
card_xes[1]=card_x+width+spacingx;
card_xes[2]=card_xes[1]+width+spacingx;

isMouseHover=array_create(3,false);

//cards

cards=array_create(3);
randomize();
list=new List(global.card_collection_count);
for(var i=0;i<list.capacity;++i){
	list.add(i);
}
var r=irandom(list.index-1);
cards[0]=global.card_collection[list.list[r]];
list.removeAt(r);

r=irandom(list.index-1);
cards[1]=global.card_collection[list.list[r]];
list.removeAt(r);

r=irandom(list.index-1);
cards[2]=global.card_collection[list.list[r]];
list.removeAt(r);

//disable shoot
obj_player.canShoot=false;