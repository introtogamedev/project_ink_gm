/// @description Insert description here
// You can write your code in this editor
mx=mouse_x-obj_camera.x;
my=mouse_y-obj_camera.y;
if(my>card_y and my<card_y_bottom){
	for(var i=0;i<3;++i){
		isMouseHover[i] = mx>card_xes[i] and mx<card_xes[i]+width;
		if(isMouseHover[i] and mouse_check_button_pressed(mb_left)){
			CardManager.card_pool.addCards(cards[i]);
			alarm[0]=1;
		}
	}
}