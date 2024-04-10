/// @description Insert description here
// You can write your code in this editor
if(_inst==pointer_null){
	_inst = instance_place(x, y, obj_enemy_base);
	if (_inst)
	{
		_inst.lose_hp(card.aoe);
	}
}