//frame stepper
isPaused=false;
stepFrame=false;


left=x-(sprite_width>>1);
right=x+(sprite_width>>1);
top=y-(sprite_height>>1);
bottom=y+(sprite_height>>1);

//velocity
xSpeed = 12;
vx=0;
vy=0;

//gravity
grav = 2;

//jump
jump_speed = 23;
isGround=collision_point(x, bottom+1,obj_ground_base,false,true);

//detect player
detect_bar=instance_create_layer(x, y, "Instances", obj_health_bar);
detect_bar.initializeHealthBar(id, 100);
detect_bar.frontColor=c_red;
detect_bar.backColor=c_grey;
detect_bar.setWidth(70);
detect_bar.setHeight(9);
detect_bar.setHp(0);
detect_bar.offsety=-100;
detect_dist= 700;
detect_dist_sqr=detect_dist*detect_dist;

//health bar
health_bar=instance_create_layer(x, y, "Instances", obj_health_bar);
health_bar.initializeHealthBar(id, 20);
health_bar.setWidth(70);
health_bar.setHeight(9);
health_bar.setHp(health_bar.maxHp);
health_bar.offsety=-125;

//attack
attack_dist=400;
attack_dist_sqr=attack_dist*attack_dist;
//melee
melee_dist=90;
melee_dist_sqr=melee_dist*melee_dist;

//detect offset
player_offsety=-90;

//lose hp
function lose_hp(_card){
	health_bar.setHp(health_bar.hp-_card.damage);
	detect_bar.setHp(detect_bar.maxHp);
	audio_play_sound(snd_hit,3,false);
	if(_card.type>4){
		state_hit.dir=sign(obj_player.x-x);
		state_goto(state_hit);
	} else if(state_cur!=state_attack and state_cur!=state_chase){
		state_goto(state_chase);
	}
	if(health_bar.hp==0){
		health_bar.destroy();
		detect_bar.destroy();
		instance_destroy();
	}
}

//state machine
function state_goto(state){
	if(state_cur!=noone){
		state_cur.onexit();
	}
	state_cur=state;
	state.onenter();
}

#region states
/* template
state_jump_down={
	obj: pointer_null,
	onenter: function(){
	},
	update: function(){
	},
	onexit: function(){
	},
	draw: function(){
	}
}
*/

function detectEnemies(walk_dir){
	var dir={
		x: obj_player.x-x,
		y: obj_player.y-y+player_offsety};
	if(sign(dir.x)!=sign(walk_dir))
		return false;
	var distsqr=dir.x*dir.x+dir.y*dir.y;
	if(distsqr<detect_dist_sqr){ //within range
		return collision_line(x,y,obj_player.x,obj_player.y,obj_ground_base,false,true)==noone;
	}
	return false;
}
function distSqrToPlayer(){
	var _x=obj_player.x-x;
	var _y=obj_player.y-y+player_offsety;
	return (_x*_x+_y*_y);
}
function enemiesAround(){
	var _x=obj_player.x-x;
	var _y=obj_player.y-y+player_offsety;
	return (_x*_x+_y*_y)<detect_dist_sqr;
}

state_idle={
	obj: pointer_null,
	prev_state: pointer_null,
	x:0,
	y:0,
	draw_obj: pointer_null,
	onenter: function(){
		obj.vx=0;
		obj.vy=0;
	},
	update: function(){
	},
	onexit: function(){
	},
	draw: function(){
		draw_set_color(c_white);
		draw_rectangle(x,y,x+10,y+10,true);
		draw_rectangle(draw_obj.x, draw_obj.y, draw_obj.x+20, draw_obj.y+20, true);
	}
	
}
state_jump_down={
	obj: pointer_null,
	walk_dir: 1,
	cur_ground: pointer_null,
	bug_counter: 0,
	onenter: function(){
		bug_counter=100;
		walk_dir=sign(obj.vx);
		cur_ground=collision_point(obj.x, obj.bottom+2, obj_ground_base, false, true);
	},
	update: function(){
		var col;
		if(walk_dir==1){
			col=collision_point(obj.right+2, obj.bottom+2, obj_ground_base, false, true);
			if(col!=noone and cur_ground!=col){
				obj.state_goto(obj.state_walk);
			}
		} else{
			col=collision_point(obj.left-2, obj.bottom+2, obj_ground_base, false, true);
			if(col!=noone and cur_ground!=col){
				obj.state_goto(obj.state_walk);
			}
		}
	},
	onexit: function(){
	},
	draw: function(){
	}
}
state_walk={
	obj: pointer_null,
	walk_speed:3,
	walk_dir:1,
	jump_max_height:250,
	jump_x_in_advance: 150,
	jump_speed:35,
	jumpdown_height: 900,
	is_jumping_down:false,
	jump_prev_sidelyUp: pointer_null,
	onenter: function(){
		obj.image_xscale=walk_dir;
	},
	update: function(){
		//walk
		if(obj.vx==0){
			walk_dir=-walk_dir;
			obj.image_xscale=walk_dir;
		}
		if(walk_dir==1){
			obj.vx=walk_speed;
			if(obj.isGround and collision_point(obj.right+2, obj.bottom+2, obj_ground_base, false, true)==noone){
				randomize();
				if(irandom(1)==1 and collision_line(obj.right+2, obj.bottom+2,obj.right+2, obj.bottom+jumpdown_height,obj_ground_base,false,true)!=noone){
					obj.state_goto(obj.state_jump_down);
				} else{
					walk_dir=-walk_dir;
					obj.image_xscale=walk_dir;
				}
			}
		} else{
			obj.vx=-walk_speed;
			if(obj.isGround and collision_point(obj.left-2, obj.bottom+2, obj_ground_base, false, true)==noone){
				randomize();
				if(irandom(1)==1 and collision_line(obj.left-2, obj.bottom+2,obj.left-2, obj.bottom+jumpdown_height,obj_ground_base,false,true)!=noone){
					obj.state_goto(obj.state_jump_down);
				} else{
					walk_dir=-walk_dir;
					obj.image_xscale=walk_dir;
				}
			}
		}
		//jump
		var dirlyUp=collision_line(obj.x,obj.bottom-2,obj.x,obj.bottom-jump_max_height,obj_ground_base,false, true);
		var sidelyUp=collision_line(obj.x+jump_x_in_advance*walk_dir,obj.bottom-2,obj.x+jump_x_in_advance*walk_dir,obj.bottom-jump_max_height,obj_ground_base,false, true)
		if(obj.isGround and sidelyUp!=jump_prev_sidelyUp and sidelyUp!=noone and dirlyUp==noone){
			randomize();
			if(irandom(1)==1){
				jump_prev_sidelyUp=sidelyUp;
			} else{
				jump_prev_sidelyUp=pointer_null;
				obj.vy=-jump_speed;
				obj.isGround=false;
			}
		}
		//detect player
		if(obj.detectEnemies(walk_dir)){
			obj.detect_bar.setHp(obj.detect_bar.hp+1);
			if(obj.detect_bar.hp==obj.detect_bar.maxHp){
				obj.state_goto(obj.state_chase);
			}
		} else{
			obj.detect_bar.setHp(obj.detect_bar.hp-0.5);
		}
	},
	onexit: function(){
		//show_debug_message("exit walk state");
	},
	draw: function(){
		//draw_set_color(c_white);
		//jump lines
		//draw_line(obj.x,obj.bottom-2,obj.x,obj.bottom-jump_max_height);
		//draw_line(obj.x+jump_x_in_advance*walk_dir,obj.bottom-2,obj.x+jump_x_in_advance*walk_dir,obj.bottom-jump_max_height);
		
		//jump down lines
		/*if(walk_dir==1)
			draw_line(obj.right+2, obj.bottom+2,obj.right+2, obj.bottom+jumpdown_height);
		else
			draw_line(obj.left-2, obj.bottom+2,obj.left-2, obj.bottom+jumpdown_height);*/
		
	}
}
state_chase={
	obj: pointer_null,
	walk_dir: 1,
	walk_speed: 4,
	//dodge
	dodge_advance: 100,
	onenter: function(){
	},
	update: function(){
		walk_dir=sign(obj_player.x-obj.x);
		if(walk_dir==1){
			obj.vx=walk_speed;
			obj.image_xscale=1;
			if(collision_point(obj.right+2, obj.bottom+2, obj_ground_base, false, true)==noone or
				collision_point(obj.right+2, obj.y, obj_ground_base, false, true)){
					obj.vx=-walk_speed;
				}
		} else{
			obj.vx=-walk_speed;
			obj.image_xscale=-1;
			if(collision_point(obj.left-2, obj.bottom+2, obj_ground_base, false, true)==noone or
				collision_point(obj.left-2, obj.y, obj_ground_base, false, true)){
					obj.vx=-walk_speed;
				}
		}
		//if there is an obstacle between player and the enemy, exit chase state
		if(collision_line(obj.x,obj.y,obj_player.x,obj_player.y+obj.player_offsety,obj_ground_base,false,true)){
			obj.state_goto(obj.state_walk);
		} else{
			var dist=obj.distSqrToPlayer();
			if(dist<obj.attack_dist_sqr){ //close enough to shoot the player
				obj.state_goto(obj.state_attack);
			} else if(dist>obj.detect_dist_sqr){ //if the player is too far, exit chase state
				obj.state_walk.walk_dir=walk_dir;
				obj.state_goto(obj.state_walk);
			}
		}
		//dodge
		
	},
	onexit: function(){
	},
	draw: function(){
	}
}
state_attack={
	obj: pointer_null,
	attack_interval: 30,
	attack_interval_counter: 0,
	first_attack_interval: 20,
	//dodge
	dodge_advance: 100,
	onenter: function(){
		obj.vx=0;
		obj.vy=0;
		attack_interval_counter=first_attack_interval;
	},
	update: function(){
		--attack_interval_counter;
		//shoot
		if(attack_interval_counter==0){
			attack_interval_counter=attack_interval;
			createBullet2(obj.x, obj.y, point_direction(obj.x,obj.y, obj_player.x,obj_player.y+obj.player_offsety));
		}
		if(obj.distSqrToPlayer()>obj.attack_dist_sqr || collision_line(obj.x,obj.y,obj_player.x,obj_player.y+obj.player_offsety,obj_ground_base,false,true)){
			obj.state_goto(obj.state_chase);
		}
		//dodge
		/*
		//left
		var cld=collision_line(obj.left-dodge_advance,obj.bottom,obj.left-dodge_advance,obj.top,obj_andytesting_card,false,true);
		if(cld!=noone and cld.card.type!=-2){ //if is player's cards
			obj.state_dodge.dir=-1;
			obj.state_dodge.prev_state=obj.state_attack;
			obj.state_goto(obj.state_dodge);
		} else{ //dodge right
			cld=collision_line(obj.right+dodge_advance,obj.bottom,obj.right+dodge_advance,obj.top,obj_andytesting_card,false,true);
			if(cld!=noone and cld.card.type!=-2){
				obj.state_dodge.dir=1;
				obj.state_dodge.prev_state=obj.state_attack;
				obj.state_goto(obj.state_dodge);
			} else{
				cld=collision_line(obj.left,obj.top-dodge_advance,obj.right,obj.top-dodge_advance,obj_andytesting_card,false,true);
				if(cld!=noone and cld.card.type!=-2){
					obj.state_dodge.dir=0;
					obj.state_dodge.prev_state=obj.state_attack;
					obj.state_goto(obj.state_dodge);
				}
			}
		}*/
	},
	onexit: function(){
	},
	draw: function(){
	}
}
state_dodge={
	obj: pointer_null,
	prev_state: pointer_null,
	dir: 0, //-1: left, 0: up, 1: right:
	jump_height: -31,
	dodge_speed: 28,
	dodge_speed_damp: 0.2,
	dodge_timer: 0,
	onenter: function(){
		dodge_timer=55;
		if(dir==0){
			randomize();
			if(irandom(1)==1){
				obj.vx=dodge_speed;
			} else{
				obj.vx=-dodge_speed;
			}
		} else{
			obj.vy=jump_height;
			obj.vx=dir==-1?dodge_speed:-dodge_speed;
		}
	},
	update: function(){
		if(obj.vx!=0){
			obj.vx=lerp(obj.vx, 0, dodge_speed_damp);
		}
		if(abs(obj.vx)<=1){
			obj.vx=0;
		}
		--dodge_timer;
		if(dodge_timer==0)
			obj.state_goto(prev_state);
	},
	onexit: function(){
	},
	draw: function(){
	}
}
state_hit={
	obj: pointer_null,
	dir: 0, //-1: left, 0: up, 1: right:
	jump_height: -10,
	dodge_speed: 28,
	dodge_speed_damp: 0.2,
	dodge_timer: 0,
	onenter: function(){
		dodge_timer=55;
		if(dir==0){
			randomize();
			if(irandom(1)==1){
				obj.vx=dodge_speed;
			} else{
				obj.vx=-dodge_speed;
			}
		} else{
			obj.vy=jump_height;
			obj.vx=dir==-1?dodge_speed:-dodge_speed;
		}
	},
	update: function(){
		if(obj.vx!=0){
			obj.vx=lerp(obj.vx, 0, dodge_speed_damp);
		}
		if(abs(obj.vx)<=1){
			obj.vx=0;
		}
		--dodge_timer;
		if(dodge_timer==0)
			obj.state_goto(obj.state_chase);
	},
	onexit: function(){
	},
	draw: function(){
	}
}
state_melee={
	obj: pointer_null,
	melee_interval: 50,
	melee_timer: 0,
	damage: 3,
	prev_state: pointer_null,
	onenter: function(){
		obj.vx=0;
		melee_timer=0;
	},
	update: function(){
		if(melee_timer==0){
			melee_timer=melee_interval;
			obj_player.lose_hp(damage);
		}
		--melee_timer;
		if(obj.distSqrToPlayer()>obj.melee_dist_sqr){
			if(prev_state==obj.state_attack)
				obj.state_goto(prev_state);
			else
				obj.state_goto(obj.state_chase);
		}
	},
	onexit: function(){
	},
	draw: function(){
	}
}
#endregion
state_walk.obj=id;
state_jump_down.obj=id;
state_idle.obj=id;
state_chase.obj=id;
state_attack.obj=id;
state_dodge.obj=id;
state_hit.obj=id;
state_melee.obj=id;

state_cur=state_walk;