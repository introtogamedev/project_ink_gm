//player movement
if(abs(vx)>1)
	vx=lerp(vx,0,0.5);
else
	vx=0;
if (keyboard_check(ord("A")))
{
	image_x = -1;
	sprite_index = anim_run;
	vx=-xSpeed;
	//obj_camera.x -= xSpeed;
	image_xscale = -3;
}
if (keyboard_check(ord("D")))
{
	image_x = 1;
	sprite_index = anim_run;
	vx = xSpeed;
	//obj_camera.x += xSpeed;
	image_xscale = 3;
}

// Jumping
if ((keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space)) && jump_timer>0)
{
	sprite_index = anim_jump;
    vy = -jump_speed;
	--jump_timer;
}

// Gravity
vy += grav;

// Vertical collision
for(var i=abs(vy);i>-1;--i){
	y+=sign(vy);
	if(place_meeting(x,y+sign(vy),obj_ground)){
		if(vy>0){
			jump_timer=jump_timer_reset;
			--y;
		} else{
			++y;
		}
		vy=0;
		break;
	}
}
//Horizontal collision
for(var i=abs(vx);i>-1;--i){
	x+=sign(vx);
	if(place_meeting(x+sign(vx),y,obj_ground)){
		x-=sign(vx);
		vx=0;
		break;
	}
}


// Update position

//shoot card


if mouse_check_button_pressed(1)
{
	if (interval_countdown >= interval)
	{
		//
		
		interval_countdown = 0;
		var cards=CardManager.shootCard();
		//cards.index
		//cards.list[0]
		//cards.at(0)
		//cards: damage, type
		var i=0;
		instantiateBullet(cards.list[i]);
		if (cards.list[i].type == 3)//3 is fast
		{
			fast_effect_countdown = fast_effect_duration;
			interval = interval_fast;
		}
		for(var i=1;i<cards.index;++i){
			if (cards.list[i].type == 3)//3 is fast
			addBullet(cards.list[i]);
		}
		
	}
}

if (fast_effect_countdown > 0)
{
	fast_effect_countdown--;
	if (fast_effect_countdown == 0)
	{
		interval = interval_normal;
	}
}
interval_countdown ++;

if(ds_queue_size(bulletQueue)>0){
    ++bulletCounter;
    if(bulletCounter>=bulletTimer){
        bullet=ds_queue_dequeue(bulletQueue);
        instantiateBullet(bullet);
		bulletCounter=0;
    }
}

if (!keyboard_check(ord("A")) && !keyboard_check(ord("D")) && !keyboard_check(ord("W")) && !keyboard_check(vk_space))
{
    sprite_index = anim_idle;
}
if (vy > 0)
{
    sprite_index = anim_fall;
}

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