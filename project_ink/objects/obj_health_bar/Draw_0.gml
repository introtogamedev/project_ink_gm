/// @description Insert description here
// You can write your code in this editor

draw_set_color(backColor);
draw_rectangle(left,top,right,bottom,false);
draw_set_color(frontColor);
draw_rectangle(left,top,left+width*hpPercentage,bottom,false);