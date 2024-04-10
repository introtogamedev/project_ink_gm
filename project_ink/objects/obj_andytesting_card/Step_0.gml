if (place_meeting(x,y,obj_ground))
{
	instance_destroy();
}

var _inst = instance_place(x, y, obj_enemy_base)

if(_inst)
{
	_inst.lose_hp(damage);
}