enum ENEMY_STATES
{
	IDLE,
	PATROL,
	CHASE,
	ATTACK
}

//statemachine variables
current_state = ENEMY_STATES.PATROL;
inner_state = 0; //0 - OnEnter, 1 - OnUpdate, 2 - OnExit
next_state = current_state;
image_speed = 0;

//idle variables
idle_spd = 4;
idle_time = 1;
timer = 0;

//chase variables
chase_spd = 5;


//get a random initial direction
randomise();
var _dir = irandom(1);
if(!_dir)
{
	_dir = -1;
}
image_xscale = _dir;

vel_x = 0;

function change_state(_next_state)
{
	next_state = _next_state;
	inner_state = 2;
}

function flip_to_target(_target)
{
	if(_target.x >= x)
	{
		image_xscale = 1;
	}
	else
	{
		image_xscale = -1;
	}
}

wall = obj_ground;
cell_size = 64;
detect_dist = cell_size * 8;
attack_dist = cell_size * 2;
melee = false;
attack_interval = 1;

max_hp = 5;
hp = 5;

function lose_hp(_hp)
{
	hp -= _hp;
}

health_bar = instance_create_layer(x, y, "Instances", obj_health_bar);
health_bar.initializeHealthBar(self, max_hp);

card = makeEmptyCard();
card.damage = 2;
card.type = -2;

raycast = undefined;
ray_max_dist = 8;
ray_current_dist = ray_max_dist;

//enemy_box = instance_create_layer(x, y, "Instances", obj_enemy_box);
//enemy_box.enemy_parent = self;

//enemy_sight = noone;