xSpeed = 12;
vsp = 0;

grav = 2;

jump_speed = 30;
jump_timer = 0;
jump_duration = 15;

invincible = false;
invincible_timer = 0;
invincible_time = 20;

interval = 30;
interval_countdown = 0;

player_health = 30;

bulletTimer=30;
bulletCounter=0;
bulletQueue = ds_queue_create();

function addBullet(_card){
    ds_queue_enqueue(bulletQueue, _card);
}
function instantiateBullet(_card){
	
	card_direction = instance_create_layer(x, y-80, "Instances", obj_andytesting_card);
	card_direction.speed = 30;
	card_direction.direction = point_direction(x,y-70,mouse_x,mouse_y);
	card_direction.image_angle = card_direction.direction;
	card_direction.card=_card;
}
