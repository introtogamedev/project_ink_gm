if (place_meeting(x,y,obj_ground))
{
	instance_destroy();
}
if(card.type>=-1){// hit enemy
	var _inst = instance_place(x, y, obj_enemy_base)

	if(_inst)
	{
		visible=false;
		_inst.lose_hp(card.damage);
		_inst.health_bar.setHp(_inst.hp);
		onHitEnemy(_inst);
		instance_destroy();
	}
} else{ // hit player
	var _inst = instance_place(x, y, obj_player)

	if(_inst)
	{
		visible=false;
		_inst.lose_hp(card.damage);
		_inst.health_bar.setHp(_inst.hp);
		onHitEnemy(_inst);
		instance_destroy();
	}
}
