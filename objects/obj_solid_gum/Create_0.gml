ground_x = function() {
	return obj_player.xspd;
}

ground_y = function() {
	return max(min(0 - obj_player.yspd - (2 * sign(obj_player.yspd)), obj_player.max_grav), -obj_player.max_grav);
}

air_x = function() {
	return max(min(0 - obj_player.xspd - (2 * sign(obj_player.xspd)), obj_player.max_grav), -obj_player.max_grav);
}

air_y = function() {
	return max(min(0 - obj_player.yspd - (2 * sign(obj_player.yspd)), obj_player.max_grav), -obj_player.max_grav);
}