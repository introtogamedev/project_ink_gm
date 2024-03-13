/// @description Insert description here
// You can write your code in this editor

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
cards=array_create(7);
<<<<<<< Updated upstream
=======
card_pool={
	length: 7,
	array: array_create(7),
	index: 0,
	shuffle_index: 0,
	
}
	

>>>>>>> Stashed changes
cards[0].sprite=spr_card2;
cards[7].sprite=spr_card1;
for(var i=0;i<5;++i){
	cards[i].sprite=spr_card1;
}
function distribute(){
	
}

#endregion