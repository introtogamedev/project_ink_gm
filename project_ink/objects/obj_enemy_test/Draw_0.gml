/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext(sprite_index, -1,x,y,image_xscale,image_yscale,0,c_white,255);

draw_set_color(c_white);
draw_circle(x,y,detect_dist,true);

state_cur.draw();