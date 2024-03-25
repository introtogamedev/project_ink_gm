/// @description Insert description here
// You can write your code in this editor
#macro CARDLEN 7

#region slot
//----drawing params-----
slot_count=5;
slot_x=90;
slot_y=527;
slot_width=124;
slot_height=182;
slot_spacing=25;
slot_padding=5;
slot_start_index=0;

//slot array
slots=array_create(slot_count);
for(var i=0;i<slot_count;++i){
	slots[i]=new Slot(i);
}

//card manager
cards=array_create(CARDLEN);
cards[0]={
	sprite: spr_card2,
	_name: "card0"
};
for(var i=1;i<CARDLEN;++i){
	cards[i]={
		sprite: spr_card1,
		_name: "card"+string(i)
	};
}

card_pool={
	length: CARDLEN,
	originalCards: array_create(CARDLEN),
	shuffledCards: ds_queue_create(),
	discardedCards: new List(CARDLEN),
	getCards: function (count){
		ret=new List(count);
		var i=0;
		for(;i<ds_queue_size(shuffledCards);++i){
			ret.add(ds_queue_dequeue(shuffledCards));
		}
		if(i<count){
			show_debug_message("getCards: i<count, reshuffle")
			shuffle();
			for(;i<count;++i)
				ret.add(ds_queue_dequeue(shuffledCards));
		}
		return ret;
	},
	shuffle: function(){
		randomize();
		indices=new List(discardedCards.index);
		for(var i=0;i<discardedCards.index;++i){
			indices.add(i);
			show_debug_message("shuffle: indices "+string(i));
		}
		var j;
		var tmp;
		for(var i=0;i<discardedCards.index;++i){
			j=irandom(indices.index);
			tmp=discardedCards.list[indices.removeAt(j)];
			show_debug_message("j="+string(j)+" card="+string(tmp._name));
			ds_queue_enqueue(shuffledCards,tmp);
		}
		discardedCards.clear();
	},
	init: function(cards){
		array_copy(originalCards, 0,cards, 0, CARDLEN);
		array_copy(discardedCards.list, 0,cards, 0, CARDLEN);
		discardedCards.index=CARDLEN;
	}
};
card_pool.init(cards);
card_pool.shuffle();
	
function distribute(){
	newcards=card_pool.getCards(5);
	for(var i=0;i<5;++i){
		slots[i].card=newcards.list[i];
		show_debug_message("distribute: i="+string(i)+", list[i].sprite="+string(slots[i].card._name));
		slots[i].isNull=false;
	}
}
function shootCard(){
	slots[slot_start_index].isNull=true;
	slots[slot_start_index].card=pointer_null;
	++slot_start_index;
	if(slot_start_index>=slot_count){
		distribute();
	}
}

distribute();

//shoot cards
shoot_card_index=0;

#endregion