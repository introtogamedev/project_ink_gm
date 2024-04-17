// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createBullet(_card, _dir){
	card_direction = instance_create_layer(x, y, "Instances", obj_andytesting_card);
	card_direction.speed = 30;
	card_direction.direction = _dir;
	card_direction.image_angle = card_direction.direction;
	card_direction.card=_card;
}