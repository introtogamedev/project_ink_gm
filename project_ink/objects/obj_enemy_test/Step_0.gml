anim_cur.update(id);
if(keyboard_check_pressed(ord("O"))){
	isPaused=!isPaused;
}
if(keyboard_check_pressed(ord("P"))){
	isPaused=true;
	stepFrame=true;
}

if(!isPaused or stepFrame){
stepFrame=false;
	
state_cur.update();
if(state_cur!=state_melee and distSqrToPlayer()<melee_dist_sqr){
	state_melee.prev_state=state_cur;
	detect_bar.setHp(detect_bar.maxHp);
	state_goto(state_melee);
}
//show_debug_message(collision_point(mouse_x,mouse_y,obj_ground, false, true));
// Jumping

// Gravity
vy += grav;

// Vertical collision
isGround=false;
for(var i=abs(vy);i>-1;--i){
	y+=sign(vy);
	if(place_meeting(x,y,obj_ground)){
		if(vy>0){
			--y;
			isGround=true;
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

//update left, right, top, bottom
left=x-(abs(sprite_width)>>1);
right=x+(abs(sprite_width)>>1);
top=y-(abs(sprite_height)>>1);
bottom=y+(abs(sprite_height)>>1);
}