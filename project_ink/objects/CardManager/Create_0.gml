/// @description Insert description here
// You can write your code in this editor
#macro CARDLEN 7

#region slot
//----drawing params-----
slot_x=90;
slot_y=527;
slot_width=124;
slot_height=182;
slot_spacing=25;
slot_padding=5;

//slot array
slots=array_create(5);
for(var i=0;i<5;++i){
	slots[i]=new Slot(i);
}
slots[0].card=new Card(spr_card1);
slots[0].isNull=false;

//card manager
cards=array_create(CARDLEN);

card_pool={
	length: CARDLEN,
	originalCards: array_create(CARDLEN),
	shuffledCards: ds_queue_create(),
	discardedCards: new List(CARDLEN),
	getCards: function (count){
	},
	shuffle: function(){
	},
	init: function(cards){
		array_copy(originalCards, 0,cards, 0, CARDLEN);
	}
};
	

cards[0].sprite=spr_card2;
for(var i=0;i<5;++i){
	cards[i].sprite=spr_card1;
}
function distribute(){
	
}

#endregion