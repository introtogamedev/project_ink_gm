/// @description Insert description here
// You can write your code in this editor

//draw header
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(Helvetica_small);
draw_text(header_x, header_y, "Choose your cards");
draw_rectangle(avail_x,avail_y,avail_w+avail_x,avail_h+avail_y,true);
draw_rectangle(select_x,select_y,avail_w+select_x,avail_h+select_y,true);

//draw available cards
draw_set_font(Helvetica_text);
draw_set_halign(fa_center);
for(var i=0;i<global.card_collection_count;++i){
	draw_sprite_stretched(global.card_collection[i].sprite, -1, available_cards[i].x,available_cards[i].y, card_width, card_height);
	draw_text( available_cards[i].x+(card_width>>1),available_cards[i].y+card_height, string(available_cards[i].count));
}
//draw selected cards
for(var i=0;i<global.card_collection_count;++i){
	draw_sprite_stretched(global.card_collection[i].sprite, -1, selected_cards[i].x,selected_cards[i].y, card_width, card_height);
	draw_text(selected_cards[i].x+(card_width>>1),selected_cards[i].y+card_height, string(selected_cards[i].count));
}

//draw description
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_rectangle(descript_x,descript_y,descript_w+descript_x,descript_h+descript_y,true);
draw_set_font(Helvetica_text);
for(var i=0;i<global.card_collection_count;++i){
	if(point_box_intersect(mouse_x,mouse_y,available_cards[i].x,available_cards[i].y, card_width, card_height)){
		draw_text_ext(descript_x+descript_text_padding,descript_y+descript_text_padding,descriptions[i],27,descript_w-(padding<<1));
		break;
	}
}

//begin button
draw_set_halign(fa_left);
draw_set_font(Helvetica_small);
draw_text(begin_x, begin_y, "press enter to begin");