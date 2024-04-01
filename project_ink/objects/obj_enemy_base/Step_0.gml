switch(current_state)
{
	case ENEMY_STATES.IDLE:
		if(inner_state == 0)
		{
			vel_x = 0;
			timer = 0;
			image_index = 0;
			
			inner_state = 1;
		}
		else if(inner_state == 1)
		{
			if(timer < idle_time)
			{
				timer += delta_time/1000000;
			}
			else
			{
				inner_state = 2;	
			}
			
			
		}
		else if(inner_state == 2)
		{
			change_state(ENEMY_STATES.PATROL);
			
			current_state = next_state;
			inner_state = 0;
		}
		break;
	case ENEMY_STATES.PATROL:
		if(inner_state == 0)
		{
			if(place_meeting(x + image_xscale*idle_spd, y, wall))
			{
				image_xscale *= -1;
			}
				
			image_index = 1;
			inner_state = 1;
		}
		else if(inner_state == 1)
		{
			vel_x = idle_spd * image_xscale;
			x += vel_x;
			

			
			if(place_meeting(x + image_xscale * idle_spd, y, wall))
			{
				inner_state = 2;
			}
			
			
		}
		else if(inner_state == 2)
		{
			change_state(ENEMY_STATES.IDLE);
				
			current_state = next_state;
			inner_state = 0;
		}
		break;
	case ENEMY_STATES.CHASE:
	
		break;
		
	case ENEMY_STATES.ATTACK:
	
		break;
}

var _xdif = abs(x - obj_player.x);
var _ydif = abs(y - obj_player.y);
var _dist = sqrt(sqr(_xdif) + sqr(_ydif));
raycast_test = raycast(x, y, 90 + image_xscale * -90, detect_dist, all);

var _i = raycast_test[? "obj"];
show_debug_message(_i == obj_player.id);

var _ray_front = collision_line(x, y, x + image_xscale * detect_dist, y, [obj_ground, obj_player], false, true);
var _ray_back = collision_line(x, y, x - image_xscale * detect_dist, y, [obj_ground, obj_player], false, true);
var _nearest = instance_nearest(x, y + image_xscale, obj_ground);
