if(returning) {
	var _dir = point_direction(x, y, o_player.x, o_player.y);
	
	x += lengthdir_x(10, _dir);
	y += lengthdir_y(10, _dir);
	
	image_angle = _dir - 180;
	direction = _dir - 180;
	
	if(point_distance(x, y, o_player.x, o_player.y) <= 16) {
		o_player.hook = noone;
		instance_destroy();
	}
} else if(o_player.state == STATE.GROUND || o_player.state == STATE.FALLING) {
	if(place_meeting(x, y, o_solid)) {
		if(moves >= o_player.hook_distance / move_spd - 2) {
			o_player.state = STATE.FALLING;
			returning = true;
		} else {
			if(o_player.state == STATE.GROUND) {
				o_player.state = STATE.HOOKING;
			}
		
			if(o_player.state == STATE.FALLING) {
				o_player.state = STATE.HOOK_FALL;
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
} else if(o_player.state == STATE.HOOK_FALL) {
	dir += rotation_spd;
	
	if(dir < max_dir_left || dir > max_dir_right) {
		rotation_spd *= -1;
	}
	
	var _last_x = o_player.x, _last_y = o_player.y;
	
	o_player.x = x + lengthdir_x(radius, dir);
	o_player.y = y + lengthdir_y(radius, dir);
	
	with(o_player) {
		if(place_meeting(o_player.x, o_player.y, o_solid)) {
			other.dir -= other.rotation_spd;
			
			o_player.x = other.x + lengthdir_x(other.radius, other.dir);
			o_player.y = other.y + lengthdir_y(other.radius, other.dir);
			
			var _mid_dir = (other.max_dir_left + other.max_dir_right) / 2;
			
			if((other.rotation_spd > 0 and other.dir <= _mid_dir) || (other.rotation_spd < 0 and other.dir >= _mid_dir)) {
				o_player.state = STATE.FALLING;
				other.returning = true;
				
				var _dir = (o_player.hook.rotation_spd < 0 ? o_player.hook.dir - 90 : o_player.hook.dir + 90);
			
				o_player.xspd = lengthdir_x(o_player.move_spd, _dir);
				o_player.yspd = lengthdir_y(o_player.move_spd, _dir);
			} else {
				other.rotation_spd *= -1;
			}
		}
	}
	
	o_player.image_xscale = max(-1, sign(rotation_spd));
	o_player.xspd = _last_x - o_player.x;
	o_player.yspd = _last_y - o_player.y;
}