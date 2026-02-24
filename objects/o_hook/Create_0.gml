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

function calc_player_spd() {
	dir = point_direction(o_player.x, o_player.y, x, y);
	radius = point_distance(x, y, o_player.x, o_player.y);
	
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
	
	
	rotation_spd = 360 * o_player.move_spd / _max_distance * _spd_dir;
}