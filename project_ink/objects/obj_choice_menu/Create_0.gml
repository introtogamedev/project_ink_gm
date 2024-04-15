/// @description Insert description here
// You can write your code in this editor




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