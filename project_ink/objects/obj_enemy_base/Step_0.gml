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