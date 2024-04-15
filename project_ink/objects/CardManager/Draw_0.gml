
var sx=slot_x+obj_camera.x, sy=slot_y+obj_camera.y;
draw_set_color(c_aqua);
for(var i=0;i<5;++i){
	if(slot_start_index==i)
		draw_set_color(c_red);
	else
		draw_set_color(c_aqua);
	draw_rectangle(sx,sy,sx+slot_width,sy+slot_height,false);
	sx+=slot_width+slot_spacing;
}