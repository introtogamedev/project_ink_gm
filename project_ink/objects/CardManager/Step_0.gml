/// @description Insert description here
// You can write your code in this editor


if(keyboard_check(vk_down)){
	++slot_height;
}
if(keyboard_check(vk_up)){
	--slot_height;
}
if(keyboard_check(vk_right)){
	++slot_width;
}
if(keyboard_check(vk_left)){
	--slot_width;
}
//show_debug_message("("+string(slot_width)+","+string(slot_height)+")");
