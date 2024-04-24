/// @description Insert description here
// You can write your code in this editor

if(keyboard_check_pressed(ord("F"))){
	shootCard();
}

if(keyboard_check_pressed(vk_tab)){
	slot_y=slot_y_up;
	updateCardPosInSlots();
}
else if(keyboard_check_released(vk_tab)){
	slot_y=slot_y_normal;
	updateCardPosInSlots();
}