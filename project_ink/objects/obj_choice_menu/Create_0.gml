/// @description Insert description here
// You can write your code in this editor

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


cards=array_create(3);
randomize();
list=new List(CardManager.CARDCNT);
for(var i=0;i<list.capacity;++i){
	list.add(i);
}
var r=irandom(list.index-1);
cards[0]=makeCardFromCollection(CardManager.card_collection[list.list[r]]);
list.removeAt(r);

r=irandom(list.index-1);
cards[1]=makeCardFromCollection(CardManager.card_collection[list.list[r]]);
list.removeAt(r);

r=irandom(list.index-1);
cards[2]=makeCardFromCollection(CardManager.card_collection[list.list[r]]);
list.removeAt(r);

cards[0].obj.visible=false;
cards[1].obj.visible=false;
cards[2].obj.visible=false;