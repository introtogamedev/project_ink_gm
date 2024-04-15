/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
draw_set_font(Helvetica);
draw_set_halign(fa_center);
draw_text_ext(middlex,topy,"choose one card to add to your deck",70,600);
for(var i=0;i<3;++i){
	draw_sprite_stretched(cards[i].sprite, 0, card_x, card_y, width, height);
	card_x+=width+spacingx;
}