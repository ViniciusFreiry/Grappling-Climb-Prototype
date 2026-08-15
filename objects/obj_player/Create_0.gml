#region Variables
move_spd = 3;
grav = 0.5;
max_grav = 10;
hook_distance = 120;
xspd = 0;
yspd = 0;
dir = 0;
hook = noone;
hook_move_spd = 8;
draw_hook_ghost = false;

initialize_states_with_animation();
#endregion

#region Functions
ground_x = function() {
	return 0;
}

ground_y = function() {
	return 0;
}

air_x = function() {
	return -xspd;
}

air_y = function() {
	return 0;
}
#endregion

#region States
state_player_ground = function() {
	change_sprite_with_animation();
	
	var _hook = mouse_check_button_pressed(mb_left);
	
	dir = (hook == noone ? point_direction(x, y, mouse_x, mouse_y) : point_direction(x, y, hook.x, hook.y));
	yspd = max(min(yspd + grav, max_grav), -max_grav);
	
	var _x_coll = instance_place(x + xspd, y, obj_solid),
	_y_coll = instance_place(x, y + yspd, obj_solid);

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
	
		while(!place_meeting(x, y + _temp_yspd, obj_solid)) {
			y += _temp_yspd;
		}

		yspd = ground_y();
		y = round(y);
	} else {
		change_state(state_player_falling, [spr_player]);
	}

	x += xspd;
	y += yspd;
	
	if(_hook and hook == noone) {
		hook = instance_create_layer(x + lengthdir_x(hook_move_spd * 2, dir), y + lengthdir_y(hook_move_spd * 2, dir), "Player", obj_hook);
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

state_player_hooking = function() {
	change_sprite_with_animation();
	
	if(hook != noone) {
		if(mouse_check_button(mb_right)) {
			if(point_distance(x, y, hook.x, hook.y) <= hook_move_spd * 2) {
				hook.returning = true;
				change_state(state_player_falling, [spr_player]);
			} else {			
				var _dir = point_direction(x, y, hook.x, hook.y);
		
				xspd = lengthdir_x(move_spd, _dir);
				yspd = lengthdir_y(move_spd, _dir);
		
				if(place_meeting(x + (xspd > -1 and xspd < 1 ? sign(xspd) : xspd), y, obj_solid)) {
					var _temp_xspd = 0.5 * sign(xspd);
	
					while(!place_meeting(x + _temp_xspd, y, obj_solid)) {
						x += _temp_xspd;
					}

					xspd = 0;
					x = round(x);
				} else {
					x += xspd;
				}

				if(place_meeting(x, y + (yspd > -1 and yspd < 1 ? sign(yspd) : yspd), obj_solid)) {
					var _temp_yspd = 0.5 * sign(yspd);
	
					while(!place_meeting(x, y + _temp_yspd, obj_solid)) {
						y += _temp_yspd;
					}

					yspd = 0;
					y = round(y);
				} else {
					y += yspd;
				}
			}
		} else if(mouse_check_button_released(mb_right)) {
			if(place_meeting(x, y + grav, obj_solid)) {
				hook.returning = true;
				change_state(state_player_ground, [spr_player]);
			} else {
				hook.calc_player_spd();
				change_state(state_player_hook_fall, [spr_player]);
			}
		} else if(mouse_check_button_pressed(mb_left)) {
			hook.returning = true;
			change_state(state_player_ground, [spr_player]);
		}
	}
}

state_player_hook_fall = function() {
	change_sprite_with_animation();
	
	if(hook != noone) {
		if(mouse_check_button_pressed(mb_left))	{
			var _dir = (hook.rotation_spd < 0 ? hook.dir - 90 : hook.dir + 90);
			
			xspd = lengthdir_x(move_spd, _dir);
			yspd = lengthdir_y(move_spd, _dir);
			
			hook.returning = true;
			change_state(state_player_falling, [spr_player]);
		}
	}
}

state_player_falling = function() {
	change_sprite_with_animation();
	
	yspd = max(min(yspd + grav, max_grav), -max_grav);
	
	var _x_coll = instance_place(x + xspd, y, obj_solid),
	_y_coll = instance_place(x, y + yspd, obj_solid);
	
	if(_x_coll) {
		ground_x = _x_coll.ground_x;
		ground_y = _x_coll.ground_y;
		air_x = _x_coll.air_x;
		air_y = _x_coll.air_y;
		
		var _temp_xspd = 0.5 * sign(xspd);
	
		while(!place_meeting(x + _temp_xspd, y, obj_solid)) {
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
	
		while(!place_meeting(x, y + _temp_yspd, obj_solid)) {
			y += _temp_yspd;
		}
		
		if(yspd > 0) change_state(state_player_ground, [spr_player]);

		yspd = air_y();
		y = round(y);
	}
	
	x += xspd;
	y += yspd;
}
#endregion

state = state_player_ground;