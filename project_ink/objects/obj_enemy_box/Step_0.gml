x = enemy_parent.x + enemy_parent.image_xscale * x_offset;
y = enemy_parent.y + y_offset;

if(place_meeting(x, y, obj_player))
{
	enemy_parent.enemy_sight = obj_player;
}
else
{
	enemy_parent.enemy_sight = noone;
}

