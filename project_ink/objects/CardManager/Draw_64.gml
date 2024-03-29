/// @description Insert description here
// You can write your code in this editor

var sx=slot_x, sy=slot_y;
draw_set_color(c_aqua);
for(var i=0;i<5;++i){
	draw_rectangle(sx,sy,sx+slot_width,sy+slot_height,false);
	if(!slots[i].isNull){
		//draw_sprite_stretched(slots[i].card.sprite, 0, sx+slot_padding,sy+slot_padding,slot_width-(slot_padding<<1),slot_height-(slot_padding<<1));
		draw_sprite_stretched(slots[i].card.sprite, 0, slots[i].bounds.x, slots[i].bounds.y, slots[i].bounds.w, slots[i].bounds.h);
	}
	sx+=slot_width+slot_spacing;
}