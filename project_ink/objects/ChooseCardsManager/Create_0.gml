global.enemy_count=0;
//draw settings
draw_set_valign(fa_top);

#region card definition
global.card_collection_count=7;
global.card_collection=array_create(global.card_collection_count);
global.card_collection[0]={
	sprite: spr_card1,
	sprite_bullet: spr_bullet_attack,
	_name: "普攻",
	damage: 1,
	type: 1
};
global.card_collection[1]={
	sprite: spr_card2,
	sprite_bullet: spr_bullet_critical_attack,
	_name: "重击",
	damage: 2,
	type: 2
}
global.card_collection[2]={
	sprite: spr_card3,
	sprite_bullet: spr_bullet_fast,
	_name: "迅势",
	damage: 0,
	type: 3
}
global.card_collection[3]={
	sprite: spr_card4,
	sprite_bullet: spr_bullet_freeze,
	_name: "凝霜",
	damage: 0,
	type: 4
}
global.card_collection[4]={
	sprite: spr_card5,
	sprite_bullet: spr_bullet_explosion,
	_name: "破阵",
	damage: 1,
	aoe: 1,
	type: 5
}
global.card_collection[5]={
	sprite: spr_card6,
	sprite_bullet: spr_bullet_hurricane,
	_name: "疾风",
	damage: 4,
	type: 6
}
global.card_collection[6]={
	sprite: spr_card7,
	sprite_bullet: spr_bullet_connect,
	_name: "连附",
	damage: 0,
	type: 7
}
descriptions=array_create(global.card_collection_count);
descriptions[0]="Attack\n\nDamage: 1\nNo Special Effects";
descriptions[1]="Critical Hit\n\nDamage: 2\nNo Special Effects";
descriptions[2]="Fast\n\nDamage: 0\nSpecial Effects: Increases your attack speed";
descriptions[3]="Freeze\n\nDamage: 1\nSpecial Effects: Freezes this card slot for 2 rounds (you'll skip this card slot when you shoot)";
descriptions[4]="Explosion\n\nDamage: 1\nSpecial Effects: Explodes when hit an enemy. Deals 1 point damage to each enemies inside it explosion.";
descriptions[5]="Hurricane\n\nDamage: 4\nSide Effects:  Empty your next card slot for one round";
descriptions[6]="Connect\n\nDamage: 1\nSpecial Effects: Shoots this card and the card on the next slot in one shot. But you lose this card from your hand once you shoot it";
#endregion
available_cards=array_create(global.card_collection_count);
global.selected_cards=array_create(global.card_collection_count);

function updateDrawPositions(arr,sx,sy,space,width,height,right_bound){
	var it_x=sx;
	var it_y=sy;
	for(var i=0;i<global.card_collection_count;++i){
		if(it_x+width>right_bound){
			it_x=sx;
			it_y+=height+space;
		}
		arr[i]={count:0,x:it_x,y:it_y};
		it_x+=width+space;
	}
}
//draw available_cards
header_x=10;
header_y=10;
avail_x=10;
avail_y=70;
avail_w=600;
avail_h=450;
card_width=119;
card_height=177;
padding=10;
spacing=30;


updateDrawPositions(available_cards, avail_x+padding, avail_y+padding,spacing,card_width,card_height,avail_x+avail_w);
available_cards[0].count=7;
available_cards[1].count=4;
available_cards[2].count=1;
available_cards[3].count=1;
available_cards[4].count=2;
available_cards[5].count=2;
available_cards[6].count=1;

//draw selected_cards
select_x=650;
select_y=70;
updateDrawPositions(global.selected_cards, select_x+padding, select_y+padding,spacing,card_width,card_height,select_x+avail_w);

//draw description
descript_x=10;
descript_y=avail_h+avail_y+20;
descript_w=600;
descript_h=200;
descript_text_padding=10;

//button
begin_x=800;
begin_y=700;

//cards chosen
global.max_card_count=12;
card_count=0;