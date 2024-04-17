/// @description Insert description here
// You can write your code in this editor
var sx=slot_x, sy=slot_y;
for(var i=0;i<5;++i){
	if(slot_start_index==i)
		draw_set_color(c_red);
	else
		draw_set_color(c_aqua);
	draw_rectangle(sx,sy,sx+slot_width,sy+slot_height,false);
	//draw cards
	if(!slots[i].isNull and slots[i].card.obj.visible){
		draw_sprite_stretched(slots[i].card.sprite,-1,slots[i].card.obj.x, slots[i].card.obj.y, slots[i].card.obj.width, slots[i].card.obj.height);
	}
	
	if(slots[i].freeze>0){
		draw_sprite(spr_frozen, 0, sx, sy);
	}
	sx+=slot_width+slot_spacing;
}