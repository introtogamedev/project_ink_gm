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
	returnedCards: new List(CARDLEN),
	getCards: function (count){
		ret=new List(count);
		var i=0;
		for(;i<ds_queue_size(shuffledCards);++i){
			ret.add(ds_queue_dequeue(shuffledCards));
		}
		if(i<count){
			show_debug_message("getCards: i<count, reshuffle")
			shuffle();
			for(;i<count;++i){
				if(ds_queue_size(shuffledCards)==0) show_debug_message("queue size is zero");
				show_debug_message(ds_queue_head(shuffledCards)._name);
				ret.add(ds_queue_dequeue(shuffledCards));
			}
		}
		show_debug_message("getCards: ret.list.count="+string(ret.index));
		for(var _i=0;_i<count;++_i){
			returnedCards.add(ret.list[_i]);
		}
		return ret;
		
		//for(i=0;i<discardedCards.index;++i){
		//	if(i<count)
		//		ret.add(discardedCards.list[i]);
		//}
	},
	shuffle: function(){
		if(returnedCards!=pointer_null){
			for(var i=0;i<returnedCards.index;++i){
				discardedCards.add(returnedCards.list[i]);
				show_debug_message("shuffle: add returnedCards: "+returnedCards.at(i)._name);
			}
			returnedCards.clear();
		}
		randomize();
		var j;
		var tmp;
		for(var i=0;i<discardedCards.index;++i){
			show_debug_message("shuffle: discardedCards["+string(i)+"]="+discardedCards.list[i]._name);
		}
		for(var i=discardedCards.index;i>0;--i){
			j=irandom(discardedCards.index-1);
			tmp=discardedCards.removeAt(j);
			show_debug_message("i="+string(i)+", j="+string(j)+" card="+string(tmp._name));
			for(var k=0;k<discardedCards.index;++k){
				show_debug_message("    |shuffle: discardedCards["+string(k)+"]="+discardedCards.list[k]._name);
			}
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
		slot_start_index=0;
		distribute();
	}
}

distribute();

//shoot cards
shoot_card_index=0;

#endregion