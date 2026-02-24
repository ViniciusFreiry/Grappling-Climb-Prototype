function ground_x() {
	return o_player.xspd;
}

function ground_y() {
	return max(min(0 - o_player.yspd - (2 * sign(o_player.yspd)), o_player.max_grav), -o_player.max_grav);
}

function air_x() {
	return max(min(0 - o_player.xspd - (2 * sign(o_player.xspd)), o_player.max_grav), -o_player.max_grav);
}

function air_y() {
	return max(min(0 - o_player.yspd - (2 * sign(o_player.yspd)), o_player.max_grav), -o_player.max_grav);
}