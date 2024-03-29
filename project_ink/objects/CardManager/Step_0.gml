/// @description Insert description here
// You can write your code in this editor

if(keyboard_check_pressed(ord("F"))){
	shootCard();
}
if(keyboard_check_pressed(vk_enter)){
	distribute();
}
cardStateMachine.cur();
//show_debug_message("("+string(slot_width)+","+string(slot_height)+")");
