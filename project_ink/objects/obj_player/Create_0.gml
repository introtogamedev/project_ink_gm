xSpeed = 12;
vx=0;
vy=0;

//gravity
grav_reset=2;
grav_light=1;
grav = 2;

//jump
jump_speed = 23;
jump_timer_reset=20;
jump_timer = jump_timer_reset;
isOnGround=true;

invincible = false;
invincible_timer = 0;
invincible_time = 20;

interval_fast = 10;
interval_normal = 30;
interval = interval_normal;
interval_countdown = 0;
interval_bar = instance_create_layer(x, y, "Instances", obj_health_bar);
interval_bar.setWidth(100);
interval_bar.setHeight(10);
interval_bar.initializeHealthBar(self, interval_normal);
interval_bar.offsety=-170;
interval_bar.frontColor=c_aqua;
interval_bar.backColor=c_grey;

fast_effect_duration = 60;
fast_effect_countdown = 0;

player_health = 30;

image_x = image_xscale;

bulletTimer=10;
bulletCounter=0;
bulletQueue = ds_queue_create();

//health bar
max_hp=30;
hp=30;
health_bar = instance_create_layer(x, y, "Instances", obj_health_bar);
health_bar.initializeHealthBar(self, max_hp);
health_bar.setWidth(100);
health_bar.setHeight(10);
health_bar.offsety=-185;

function addBullet(_card){
    ds_queue_enqueue(bulletQueue, _card);
}
function instantiateBullet(_card){
	card_direction = instance_create_layer(x, y-120, "Instances", obj_andytesting_card);
	card_direction.speed = 30;
	card_direction.direction = point_direction(x,y-100,mouse_x,mouse_y);
	card_direction.image_angle = card_direction.direction;
	card_direction.card=_card;
}
function lose_hp(h){
	hp-=h;
	if(hp<0){
		room_goto(Scene_GameOver);
	}
	health_bar.setHp(hp);
}

//shoot
canShoot=true;