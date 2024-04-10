//player movement
if (keyboard_check(ord("A")) && !place_meeting(x-10,y,obj_ground))
{
	x -= xSpeed;
	//obj_camera.x -= xSpeed;
	image_xscale = -3;
}

if (keyboard_check(ord("D")) && !place_meeting(x+10,y,obj_ground))
{
	x += xSpeed;
	//obj_camera.x += xSpeed;
	image_xscale = 3;
}

// Jumping
if (place_meeting(x, y + 1, obj_ground) && (keyboard_check_pressed(ord("W")) || keyboard_check(vk_space)))
{
    vsp = -jump_speed;
}

// Gravity
vsp += grav;

// Vertical collision
if (place_meeting(x, y + vsp, obj_ground))
{
    while (!place_meeting(x, y + sign(vsp), obj_ground))
    {
        y += sign(vsp);
    }
    vsp = 0;
}

// Update position
y += vsp;

//shoot card
if mouse_check_button_pressed(1)
{
	if (interval_countdown >= interval)
	{
		card_direction = instance_create_layer(x, y-80, "Instances", obj_andytesting_card);
		card_direction.speed = 30;
		card_direction.direction = point_direction(x,y-70,mouse_x,mouse_y);
		card_direction.image_angle = card_direction.direction;
		
		interval_countdown = 0;
		var cards=CardManager.shootCard();
		//cards.index
		//cards.list[0]
		//cards.at(0)
		//cards: damage, type
		for(var i=0;i<cards.index;++i){
			alarm[0]=10;
			show_debug_message(cards.list[i]._name);
		}
		
	}
}
interval_countdown ++;

//invincible time
if (invincible)
{
	invincible_timer++;
	if (invincible_timer > invincible_time)
	{
		invincible = false;
		invincible_timer = 0;
	}
}

//die