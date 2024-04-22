/// @description Insert description here
// You can write your code in this editor
if(place_meeting(x,y,obj_player)){
	instance_create_layer(0, 0, "Instances", obj_choice_menu);
	instance_destroy();
}