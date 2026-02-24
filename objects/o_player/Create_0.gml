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

enum STATE {
	GROUND,
	HOOKING,
	HOOK_FALL,
	FALLING
}

state = STATE.FALLING;

function ground_x() {
	return 0;
}

function ground_y() {
	return 0;
}

function air_x() {
	return -xspd;
}

function air_y() {
	return 0;
}

window_set_cursor(cr_cross);
window_set_fullscreen(true);
view_wport[0] = display_get_width();
view_hport[0] = display_get_height();
surface_resize(application_surface, display_get_width(), display_get_height());