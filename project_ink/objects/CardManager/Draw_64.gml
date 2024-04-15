/// @description Insert description here
// You can write your code in this editor
var sx=slot_x+obj_camera.x, sy=slot_y+obj_camera.y;
for(var i=0;i<5;++i){
	if(slots[i].freeze>0){
		draw_sprite(spr_frozen, 0, sx, sy);
	}
	sx+=slot_width+slot_spacing;
}