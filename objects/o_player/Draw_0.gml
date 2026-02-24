if(state == STATE.GROUND and hook == noone) {
	var _temp_hook = instance_create_layer(x + lengthdir_x(hook_move_spd * 2, dir), y + lengthdir_y(hook_move_spd * 2, dir), "Player", o_hook);
	var _dis = 0;

	_temp_hook.direction = dir;
	_temp_hook.image_angle = dir;

	for(var _i = 1; _i < hook_distance / hook_move_spd; _i++) {
		with(_temp_hook) {
			if(place_meeting(_temp_hook.x, _temp_hook.y, o_solid)) {
				other.draw_hook_ghost = true;	
			} else {
				draw_sprite(s_ghost_path, 0, _temp_hook.x, _temp_hook.y);
				other.draw_hook_ghost = false;
			}
		}
	
		if(draw_hook_ghost) {
			draw_sprite_ext(s_hook_ghost, 0, _temp_hook.x, _temp_hook.y, 1, 1, dir, c_white, 1);
		
			break;
		}
	
		_temp_hook.x += lengthdir_x(hook_move_spd, dir);
		_temp_hook.y += lengthdir_y(hook_move_spd, dir);
	}

	instance_destroy(_temp_hook);
}

draw_self();

if(hook == noone) {
	var _dir = point_direction(x, y, mouse_x, mouse_y);
	
	draw_sprite_ext(s_grappling, 0, x + lengthdir_x(16, _dir), y + lengthdir_y(16, _dir), 1, image_xscale, _dir, c_white, 1);
} else {
	var _dir = point_direction(x, y, hook.x, hook.y);
	
	draw_sprite_ext(s_grappling, 1, x + lengthdir_x(16, _dir), y + lengthdir_y(16, _dir), 1, image_xscale, _dir, c_white, 1);
}