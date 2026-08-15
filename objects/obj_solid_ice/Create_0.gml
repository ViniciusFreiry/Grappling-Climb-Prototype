ground_x = function() {
	var _new_xspd = obj_player.xspd - (0.1 * sign(obj_player.xspd))
	
	return (sign(obj_player.xspd) != sign(_new_xspd) ? 0 : _new_xspd);
}

ground_y = function() {
	return 0;
}

air_x = function() {
	return -obj_player.xspd;
}

air_y = function() {
	return 0;
}