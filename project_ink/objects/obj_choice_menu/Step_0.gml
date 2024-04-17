/// @description Insert description here
// You can write your code in this editor
if(mouse_y>card_y and mouse_y<card_y_bottom){
	for(var i=0;i<3;++i){
		isMouseHover[i] = mouse_x>card_xes[i] and mouse_x<card_xes[i]+width;
	}
}