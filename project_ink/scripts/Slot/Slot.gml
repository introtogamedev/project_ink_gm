// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Slot(_index) constructor{
	index=_index;
	isNull=true;
	freeze=0;
}
function Card(spr) constructor{
	sprite=spr;
}
function makeEmptyCard(){
	var card={};
	card.obj=pointer_null;
	card.sprite=pointer_null;
	card._name="empty";
	card.damage=0;
	card.type=-1;
	return card;
}
function makeCardFromCollection(prototype){
	var card={};
	card.obj= instance_create_layer(0,0,"Cards", obj_card);
	card.sprite= prototype.sprite;
	card.obj.sprite_index=card.sprite;
	card._name= prototype._name;
	card.damage= prototype.damage;
	card.type= prototype.type;
	return card;
}