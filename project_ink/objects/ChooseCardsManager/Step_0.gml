//handle mouse clicking
if(mouse_check_button_pressed(mb_left)){
	for(var i=0;i<global.card_collection_count;++i){
		if(card_count<global.max_card_count and point_box_intersect(mouse_x,mouse_y,available_cards[i].x,available_cards[i].y, card_width, card_height)){
			if(available_cards[i].count>0){
				--available_cards[i].count;
				++global.selected_cards[i].count;
				++card_count;
			}
			break;
		}
		else if(point_box_intersect(mouse_x,mouse_y,global.selected_cards[i].x,global.selected_cards[i].y, card_width, card_height)){
			if(global.selected_cards[i].count>0){
				++available_cards[i].count;
				--global.selected_cards[i].count;
				--card_count;
			}
			break;
		}
	}
}
//start the game
if(keyboard_check_pressed(vk_enter) and (card_count==global.max_card_count || card_count==0)){
	if(card_count==0){
		global.selected_cards[0].count=5;
		global.selected_cards[1].count=2;
		global.selected_cards[2].count=1;
		global.selected_cards[3].count=1;
		global.selected_cards[4].count=1;
		global.selected_cards[5].count=1;
		global.selected_cards[6].count=1;
	}
	room_goto(Scene_Andy);
}