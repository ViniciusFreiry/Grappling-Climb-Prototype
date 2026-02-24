function ground_x() {
	var _new_xspd = o_player.xspd - (0.1 * sign(o_player.xspd))
	
	return (sign(o_player.xspd) != sign(_new_xspd) ? 0 : _new_xspd);
}

function ground_y() {
	return 0;
}

function air_x() {
	return -o_player.xspd;
}

function air_y() {
	return 0;
}