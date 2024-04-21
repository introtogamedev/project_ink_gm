/// @description Insert description here
// You can write your code in this editor

#region slot
//----drawing params-----
slot_count=5;
slot_x=50;
slot_y=570;
slot_width=124;
slot_height=182;
slot_spacing=25;
slot_padding=5;
slot_start_index=0;

//slot array
//struct card
//bool isNull
//int freeze
slots=array_create(slot_count);
for(var i=0;i<slot_count;++i){
	slots[i]=new Slot(i);
}
//card manager
CARDLEN=global.max_card_count;
cards=array_create(CARDLEN);
for(var i=0,j=0;i<CARDLEN;++i){
	while(global.selected_cards[j].count==0){
		++j;
	}
	cards[i]=makeCardFromCollection(global.card_collection[j]);
	--global.selected_cards[j].count;
}
/*
cards[0]=makeCardFromCollection(card_collection[0]);
cards[1]=makeCardFromCollection(card_collection[0]);
cards[2]=makeCardFromCollection(card_collection[0]);
cards[3]=makeCardFromCollection(card_collection[0]);
cards[4]=makeCardFromCollection(card_collection[0]);
cards[5]=makeCardFromCollection(card_collection[1]);
cards[6]=makeCardFromCollection(card_collection[1]);
cards[7]=makeCardFromCollection(card_collection[2]);
cards[8]=makeCardFromCollection(card_collection[3]);
cards[9]=makeCardFromCollection(card_collection[4]);
cards[10]=makeCardFromCollection(card_collection[5]);
cards[11]=makeCardFromCollection(card_collection[6]);
*/

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
			shuffle();
			for(;i<count;++i){
				ret.add(ds_queue_dequeue(shuffledCards));
			}
		}
		return ret;
	},
	shuffle: function(){
		if(returnedCards!=pointer_null){
			for(var i=0;i<returnedCards.index;++i){
				discardedCards.add(returnedCards.list[i]);
			}
			returnedCards.clear();
		}
		randomize();
		var j;
		var tmp;
		for(var i=discardedCards.index;i>0;--i){
			j=irandom(discardedCards.index-1);
			tmp=discardedCards.removeAt(j);
			ds_queue_enqueue(shuffledCards,tmp);
		}
		discardedCards.clear();
	},
	addCards: function(prototype){
		returnedCards.add(makeCardFromCollection(prototype));
	},
	init: function(cards){
		array_copy(originalCards, 0,cards, 0, length);
		array_copy(discardedCards.list, 0,cards, 0, length);
		discardedCards.index=length;
	}
};
card_pool.init(cards);
card_pool.shuffle();
	
function distribute(){
	var cnt=0;
	for(var i=0;i<5;++i){
		if(slots[i].isNull) { ++cnt;}
	}
	newcards=card_pool.getCards(cnt);
	cnt=0;
	var tmp=pointer_null;
	for(var i=0;i<5;++i){
		if(slots[i].isNull){
			slots[i].card=newcards.list[cnt];
			slots[i].card.obj.x=slot_x+slot_padding+i*(slot_width+slot_spacing)
			slots[i].card.obj.y=slot_y+slot_padding;
			slots[i].card.obj.visible=true;
			slots[i].isNull=false;
			++cnt;
		}
		else{
			tmp=slots[i].card.obj;
		}
		if(slots[i].freeze>0){
			--slots[i].freeze;
		}
	}
}
function discardNextCard(){
	var tmp=slot_start_index+1;
	for(var i=tmp ;i<5;++i){
		if(slots[i].freeze==0){
			card_pool.discardedCards.add(slots[i].card);
			slots[i].isNull=true;
			slots[i].card.obj.visible=false;
			slots[i].card=pointer_null;
			return;
		}
	}
}
function shootCard(){
	var tmp=new List(5);
	if(!slots[slot_start_index].isNull){
		slots[slot_start_index].card.obj.visible=false;
		tmp.add(slots[slot_start_index].card);
		card_pool.returnedCards.add(slots[slot_start_index].card);
		slots[slot_start_index].isNull=true;
		slots[slot_start_index].card=pointer_null;
		switch(tmp.list[0].type){  //implement different card effects
			case 4: //freeze
				slots[slot_start_index].freeze+=2;
				break;
			case 6: //hurricane
				discardNextCard();
				break;
			case 7: //connect
				--card_pool.returnedCards.index;
				for(var i=slot_start_index+1 ;i<5;++i){
					if(slots[slot_start_index].freeze==0){
						slot_start_index=i;
						tmp.addRange(shootCard());
						return tmp;
					}
				}
				break;
		}
	}
	++slot_start_index;
	if(slot_start_index>=slot_count){
		slot_start_index=0;
		distribute();
	}
	while(slots[slot_start_index].freeze>0){
		++slot_start_index;
		if(slot_start_index>=slot_count){
			slot_start_index=0;
			distribute();
		}
	}
	if(tmp.index==0){ //if no cards are shot
		tmp.add(makeEmptyCard());
	}
	return tmp;
}

distribute();
//shoot cards
shoot_card_index=0;

#endregion
