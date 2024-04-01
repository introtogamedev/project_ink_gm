//player movement
if (keyboard_check(ord("A")) && !place_meeting(x-5,y,obj_wall))
{
	x -= xSpeed;
	//obj_camera.x -= xSpeed;
	image_xscale = -3;
}

if (keyboard_check(ord("D")) && !place_meeting(x+15,y,obj_wall))
{
	x += xSpeed;
	//obj_camera.x += xSpeed;
	image_xscale = 3;
}

// Jumping
if (place_meeting(x, y + 1, obj_ground) && keyboard_check_pressed(ord("W")))
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