/// @description Insert description here
// You can write your code in this editor
function decrease_enemy_count(){
	global.enemy_count--;
	if(global.enemy_count==0){
		room_goto(Scene_Win);
	}
}