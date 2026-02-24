function player_ground(){
	var _hook = mouse_check_button_pressed(mb_left);
	
	dir = (hook == noone ? point_direction(x, y, mouse_x, mouse_y) : point_direction(x, y, hook.x, hook.y));
	yspd = max(min(yspd + grav, max_grav), -max_grav);
	
	var _x_coll = instance_place(x + xspd, y, o_solid);
	var _y_coll = instance_place(x, y + yspd, o_solid);

	if(_x_coll) {
		xspd = ground_x();
		
		ground_x = _x_coll.ground_x;
		ground_y = _x_coll.ground_y;
		air_x = _x_coll.air_x;
		air_y = _x_coll.air_y;
		
		xspd = air_x();
		x = round(x);
	} else {
		xspd = ground_x();
	}

	if(_y_coll) {
		ground_x = _y_coll.ground_x;
		ground_y = _y_coll.ground_y;
		air_x = _y_coll.air_x;
		air_y = _y_coll.air_y;
		
		var _temp_yspd = 0.5 * sign(yspd);
	
		while(!place_meeting(x, y + _temp_yspd, o_solid)) {
			y += _temp_yspd;
		}

		yspd = ground_y();
		y = round(y);
	} else {
		state = STATE.FALLING;	
	}

	x += xspd;
	y += yspd;
	
	if(_hook and hook == noone) {
		hook = instance_create_layer(x + lengthdir_x(hook_move_spd * 2, dir), y + lengthdir_y(hook_move_spd * 2, dir), "Player", o_hook);
		hook.dir = dir;
		hook.move_spd = hook_move_spd;
		hook.moves = hook_distance / hook_move_spd - 2;
		hook.image_angle = hook.dir;
		hook.direction = hook.dir;
	}
	
	if(dir > 90 and dir < 270) {
		image_xscale = -1;	
	} else {
		image_xscale = 1;	
	}
}

function player_hooking() {
	if(hook != noone) {
		if(mouse_check_button(mb_right)) {
			if(point_distance(x, y, hook.x, hook.y) <= hook_move_spd * 2) {
				state = STATE.FALLING;
				hook.returning = true;
			} else {			
				var _dir = point_direction(x, y, hook.x, hook.y);
		
				xspd = lengthdir_x(move_spd, _dir);
				yspd = lengthdir_y(move_spd, _dir);
		
				if(place_meeting(x + (xspd > -1 and xspd < 1 ? sign(xspd) : xspd), y, o_solid)) {
					var _temp_xspd = 0.5 * sign(xspd);
	
					while(!place_meeting(x + _temp_xspd, y, o_solid)) {
						x += _temp_xspd;
					}

					xspd = 0;
					x = round(x);
				} else {
					x += xspd;
				}

				if(place_meeting(x, y + (yspd > -1 and yspd < 1 ? sign(yspd) : yspd), o_solid)) {
					var _temp_yspd = 0.5 * sign(yspd);
	
					while(!place_meeting(x, y + _temp_yspd, o_solid)) {
						y += _temp_yspd;
					}

					yspd = 0;
					y = round(y);
				} else {
					y += yspd;
				}
			}
		} else if(mouse_check_button_released(mb_right)) {
			if(place_meeting(x, y + grav, o_solid)) {
				state = STATE.GROUND;
				hook.returning = true;
			} else {
				state = STATE.HOOK_FALL;
				hook.calc_player_spd();
			}
		} else if(mouse_check_button_pressed(mb_left)) {
			state = STATE.GROUND;
			hook.returning = true;
		}
	}
}

function player_hook_fall() {
	if(hook != noone) {
		if(mouse_check_button_pressed(mb_left))	{
			state = STATE.FALLING;
			hook.returning = true;
			
			var _dir = (hook.rotation_spd < 0 ? hook.dir - 90 : hook.dir + 90);
			
			xspd = lengthdir_x(move_spd, _dir);
			yspd = lengthdir_y(move_spd, _dir);
		}
	}
}

function player_falling() {
	yspd = max(min(yspd + grav, max_grav), -max_grav);
	
	var _x_coll = instance_place(x + xspd, y, o_solid);
	var _y_coll = instance_place(x, y + yspd, o_solid);
	
	if(_x_coll) {
		ground_x = _x_coll.ground_x;
		ground_y = _x_coll.ground_y;
		air_x = _x_coll.air_x;
		air_y = _x_coll.air_y;
		
		var _temp_xspd = 0.5 * sign(xspd);
	
		while(!place_meeting(x + _temp_xspd, y, o_solid)) {
			x += _temp_xspd;
		}

		xspd = air_x();
		x = round(x);
	}

	if(_y_coll) {
		ground_x = _y_coll.ground_x;
		ground_y = _y_coll.ground_y;
		air_x = _y_coll.air_x;
		air_y = _y_coll.air_y;
		
		var _temp_yspd = 0.5 * sign(yspd);
	
		while(!place_meeting(x, y + _temp_yspd, o_solid)) {
			y += _temp_yspd;
		}
		
		if(yspd > 0) state = STATE.GROUND;

		yspd = air_y();
		y = round(y);
	}
	
	x += xspd;
	y += yspd;
}