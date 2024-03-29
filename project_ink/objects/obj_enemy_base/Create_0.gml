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