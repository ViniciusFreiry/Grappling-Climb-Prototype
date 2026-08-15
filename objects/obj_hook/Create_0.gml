dir = 0;
move_spd = 8;
moves = 0;
rotation_spd = 0;
radius = 0;
max_dir_right = 0;
max_dir_left = 0;
returning = false;

player_xspd = 0;
player_yspd = 0;

draw_hook = function() {
	if(instance_exists(obj_player)) draw_sprite_ext(spr_rope, 0, obj_player.x, obj_player.y, ((point_distance(obj_player.x, obj_player.y, x, y) + 1) / sprite_get_width(spr_rope)), 1, point_direction(obj_player.x, obj_player.y, x, y), c_white, 1);
	draw_self();
}

calc_player_spd = function() {
	if(!instance_exists(obj_player)) return;
	
	dir = point_direction(obj_player.x, obj_player.y, x, y);
	radius = point_distance(x, y, obj_player.x, obj_player.y);
	
	var _max_distance = 2 * pi * radius;
	var _distance = 360;
	var _spd_dir = 1;
	
	if(dir < 90) {
		_distance = (90 - dir) * 2;
		_spd_dir = -1;
		
		dir += 180;
		max_dir_left = dir;
		max_dir_right = max_dir_left + _distance;
	} else if(dir < 180) {
		_distance = (dir - 90) * 2;
		_spd_dir = 1;
		
		dir += 180;
		max_dir_right = dir;
		max_dir_left = max_dir_right - _distance;
	} else if(dir < 270) {
		_distance = (dir - 90) * 2;
		_spd_dir = 1;
		
		dir += 180;
		max_dir_right = dir;
		max_dir_left = max_dir_right - _distance;
	} else {
		_distance -= ((dir - 270) * 2);
		_spd_dir = -1;
		
		dir -= 180;
		max_dir_left = dir;
		max_dir_right = max_dir_left + _distance;
	}
	
	
	rotation_spd = 360 * obj_player.move_spd / _max_distance * _spd_dir;
}

hook_controll = function() {
	if(!instance_exists(obj_player) or global.pause) exit;

	if(returning) {
		var _dir = point_direction(x, y, obj_player.x, obj_player.y);
	
		x += lengthdir_x(10, _dir);
		y += lengthdir_y(10, _dir);
	
		image_angle = _dir - 180;
		direction = _dir - 180;
	
		if(point_distance(x, y, obj_player.x, obj_player.y) <= 16) {
			obj_player.hook = noone;
			instance_destroy();
		}
	} else if(obj_player.state == obj_player.state_player_ground || obj_player.state == obj_player.state_player_falling) {
		if(place_meeting(x, y, obj_solid)) {
			if(moves >= obj_player.hook_distance / move_spd - 2) {
				obj_player.state = obj_player.state_player_falling;
				returning = true;
			} else {
				if(obj_player.state == obj_player.state_player_ground) {
					obj_player.state = obj_player.state_player_hooking;
				}
		
				if(obj_player.state == obj_player.state_player_falling) {
					obj_player.state = obj_player.state_player_hook_fall;
					calc_player_spd();
				}
			}
		} else if(moves <= 0) {
			returning = true;
		} else {
			x += lengthdir_x(move_spd, dir);
			y += lengthdir_y(move_spd, dir);
			moves--;
		}
	} else if(obj_player.state == obj_player.state_player_hook_fall) {
		dir += rotation_spd;
	
		if(dir < max_dir_left || dir > max_dir_right) {
			rotation_spd *= -1;
		}
	
		var _last_x = obj_player.x, _last_y = obj_player.y;
	
		obj_player.x = x + lengthdir_x(radius, dir);
		obj_player.y = y + lengthdir_y(radius, dir);
	
		with(obj_player) {
			if(place_meeting(obj_player.x, obj_player.y, obj_solid)) {
				other.dir -= other.rotation_spd;
			
				obj_player.x = other.x + lengthdir_x(other.radius, other.dir);
				obj_player.y = other.y + lengthdir_y(other.radius, other.dir);
			
				var _mid_dir = (other.max_dir_left + other.max_dir_right) / 2;
			
				if((other.rotation_spd > 0 and other.dir <= _mid_dir) || (other.rotation_spd < 0 and other.dir >= _mid_dir)) {
					obj_player.state = obj_player.state_player_falling;
					other.returning = true;
				
					var _dir = (obj_player.hook.rotation_spd < 0 ? obj_player.hook.dir - 90 : obj_player.hook.dir + 90);
			
					obj_player.xspd = lengthdir_x(obj_player.move_spd, _dir);
					obj_player.yspd = lengthdir_y(obj_player.move_spd, _dir);
				} else {
					other.rotation_spd *= -1;
				}
			}
		}
	
		obj_player.image_xscale = max(-1, sign(rotation_spd));
		obj_player.xspd = _last_x - obj_player.x;
		obj_player.yspd = _last_y - obj_player.y;
	}
}