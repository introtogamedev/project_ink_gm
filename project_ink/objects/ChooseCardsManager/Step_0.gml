/// @description Insert description here
// You can write your code in this editor
if(mouse_check_button_pressed(mb_left)){
	for(var i=0;i<global.card_collection_count;++i){
		if(point_box_intersect(mouse_x,mouse_y,available_cards[i].x,available_cards[i].y, card_width, card_height)){
			if(available_cards[i].count>0){
				--available_cards[i].count;
				++selected_cards[i].count;
			}
			break;
		}
		else if(point_box_intersect(mouse_x,mouse_y,selected_cards[i].x,selected_cards[i].y, card_width, card_height)){
			if(selected_cards[i].count>0){
				++available_cards[i].count;
				--selected_cards[i].count;
			}
			break;
		}
	}
}
if(keyboard_check_pressed(vk_enter)){
	room_goto(Scene_Andy);
}