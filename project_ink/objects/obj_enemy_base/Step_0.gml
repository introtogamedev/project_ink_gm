var _distx = abs(x - obj_player.x);
var _disty = abs(y - obj_player.y);
var _dist = sqrt(sqr(_distx) + sqr(_disty))

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
			
			if(_dist < detect_dist)
			{
				change_state(ENEMY_STATES.CHASE);
				current_state = next_state;
				inner_state = 0;
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
				if(place_meeting(x + image_xscale*idle_spd, y, wall)
				|| (!place_meeting(x + image_xscale * -1 * sprite_width, y + cell_size, wall) && image_xscale < 0)
				|| (!place_meeting(x + sprite_width , y + cell_size, wall) && image_xscale >= 0))
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
				
				if(place_meeting(x + image_xscale * idle_spd, y, wall)
				|| (!place_meeting(x + image_xscale * -1 * sprite_width, y + cell_size, wall) && image_xscale < 0)
				|| (!place_meeting(x + sprite_width , y + cell_size, wall) && image_xscale >= 0))
				{
					inner_state = 2;
				}
				
				
				if(_dist < detect_dist)
				{
					change_state(ENEMY_STATES.CHASE);
					current_state = next_state;
					inner_state = 0;
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
			if(inner_state == 0)
			{
				inner_state = 1;
			}
			else if(inner_state == 1)
			{
				if(_dist > attack_dist)
				{
					flip_to_target(obj_player);
					vel_x = image_xscale * chase_spd;
				}
				else
				{
					change_state(ENEMY_STATES.ATTACK);
					current_state = next_state;
					inner_state = 0;
					vel_x = 0;
				}
			
				if(place_meeting(x + vel_x, y, obj_ground)
				|| (!place_meeting(x + image_xscale * -1 * sprite_width, y + cell_size, wall) && image_xscale < 0)
				|| (!place_meeting(x + sprite_width , y + cell_size, wall) && image_xscale >= 0))
				{
					vel_x = 0;
				}
			
				if(_dist > detect_dist)
				{
					change_state(ENEMY_STATES.PATROL);
					current_state = next_state;
					inner_state = 0;
				}
			
				x += vel_x;
			}
			else if(inner_state == 2)
			{
				
			}
		break;
		
	case ENEMY_STATES.ATTACK:
			if(inner_state == 0)
			{
				inner_state = 1;
				timer = 0;
			}
			else if(inner_state == 1)
			{
				if(melee)
				{
			
				}
				else
				{
					if(timer >= attack_interval)
					{
						var _deg = point_direction(x, y, obj_player.x, obj_player.y-60);
					
						createBullet(card, _deg);
						timer = 0;
					}
					else
					{
						timer += delta_time/1000000;
					}
					
					if(_dist > detect_dist)
					{
						inner_state = 2;
					}
					
				}
			}
			else if(inner_state == 2)
			{
				change_state(ENEMY_STATES.PATROL);
				current_state = next_state;
				inner_state = 0;
			}
		
		break;
}

health_bar.setPosition(x, y - 128);

if(current_state == ENEMY_STATES.CHASE)
{
	image_alpha = 0.5;
}
else
{
	image_alpha = 1;
}




ray_end_x = x + image_xscale * ray_current_dist;
ray_end_y = y;

raycast = collision_line_list(x, y, ray_end_x, ray_end_y, obj_ground, false, true, raycast_list, true);

var _inst = ds_list_find_value(raycast_list, 0);
if(raycast != 0)
{
	ray_current_dist = abs(x - _inst.x);
}

ray_current_dist = clamp(ray_current_dist, 0, ray_max_dist);