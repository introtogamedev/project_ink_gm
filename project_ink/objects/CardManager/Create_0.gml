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
//struct card
//bool isNull
//int freeze
slots=array_create(slot_count);
for(var i=0;i<slot_count;++i){
	slots[i]=new Slot(i);
}

//card manager
cards=array_create(CARDLEN);
cards[0]={
	sprite: spr_card1,
	_name: "普攻",
	damage: 1,
	type: 1
};
cards[1]={
	sprite: spr_card2,
	_name: "重击",
	damage: 2,
	type: 2
}
cards[2]={
	sprite: spr_card3,
	_name: "迅势",
	damage: 0,
	type: 3
}
cards[3]={
	sprite: spr_card4,
	_name: "凝霜",
	damage: 0,
	type: 4
}
cards[4]={
	sprite: spr_card5,
	_name: "破阵",
	damage: 1,
	type: 5
}
cards[5]={
	sprite: spr_card6,
	_name: "疾风",
	damage: 3,
	type: 6
}
cards[6]={
	sprite: spr_card7,
	_name: "连附",
	damage: 0,
	type: 7
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
			shuffle();
			for(;i<count;++i){
				ret.add(ds_queue_dequeue(shuffledCards));
			}
		}
		for(var _i=0;_i<count;++_i){
			returnedCards.add(ret.list[_i]);
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
	init: function(cards){
		array_copy(originalCards, 0,cards, 0, CARDLEN);
		array_copy(discardedCards.list, 0,cards, 0, CARDLEN);
		discardedCards.index=CARDLEN;
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
	for(var i=0;i<5;++i){
		if(slots[i].isNull){
			slots[i].card=newcards.list[cnt];
			slots[i].isNull=false;
			++cnt;
		}
		if(slots[i].freeze>0){
			--slots[i].freeze;
		}
	}
}
function shootCard(){
	while(slots[slot_start_index].freeze>0){
		++slot_start_index;
		if(slot_start_index>=slot_count){
			slot_start_index=0;
			distribute();
		}
	}
	var tmp=new List(5);
	tmp.add(slots[slot_start_index].card);
	slots[slot_start_index].isNull=true;
	slots[slot_start_index].card=pointer_null;
	switch(tmp.list[0].type){  //implement different card effects
		case 4: //freeze
			slots[slot_start_index].freeze+=2;
			break;
		case 7: //connect
			for(var i=slot_start_index+1 ;i<5;++i){
				if(slots[slot_start_index].freeze==0){
					slot_start_index=i;
					tmp.addRange(shootCard());
					return tmp;
				}
			}
			break;
	}
	++slot_start_index;
	if(slot_start_index>=slot_count){
		slot_start_index=0;
		distribute();
	}
	return tmp;
}

distribute();

//shoot cards
shoot_card_index=0;

#endregion