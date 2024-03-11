/// @description Insert description here
// You can write your code in this editor

var sx=slot_x, sy=slot_y;
draw_set_color(c_white);
for(var i=0;i<5;++i){
	draw_rectangle(sx,sy,sx+slot_width,sy+slot_height,false);
	sx+=slot_width+slot_spacing;
}




