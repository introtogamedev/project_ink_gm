if (place_meeting(x,y,obj_ground))
{
	instance_destroy();
}

if (place_meeting(x,y,obj_enemy_base))
{
	visible = false;
}

var _inst = instance_place(x, y, obj_enemy_base)

if(_inst)
{
	_inst.lose_hp(card.damage);
	_inst.health_bar.setHp(_inst.hp);
	onHitEnemy(_inst);
	instance_destroy();
}