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
		var obj=instance_create_layer(_inst.x,_inst.y-_inst.sprite_height,"Instances", obj_damage_indicator);
		obj.damage=card.damage;
		onHitEnemy(_inst);
		instance_destroy();
	}
	
	_inst=instance_place(x,y,obj_enemy_test);
	if(_inst){
		_inst.lose_hp(card);
		onHitEnemy(_inst);
		var obj=instance_create_layer(_inst.x,_inst.y-_inst.sprite_height,"Instances", obj_damage_indicator);
		obj.damage=card.damage;
		instance_destroy();
	}
} else{ // hit player
	var _inst = instance_place(x, y, obj_player)

	if(_inst)
	{
		visible=false;
		_inst.lose_hp(card.damage);
		_inst.health_bar.setHp(_inst.hp);
		var obj=instance_create_layer(_inst.x,_inst.y-_inst.sprite_height,"Instances", obj_damage_indicator);
		obj.damage=card.damage;
		onHitEnemy(_inst);
		instance_destroy();
	}
}
