is_paused = false;

pause_time = 15;
pause_timer = 0;

draw_x = camera_get_view_x(view_camera[0]) + 320;
draw_y = camera_get_view_y(view_camera[0]) + 200;
menu_scale = 0;

button_return = noone;

function game_pause(_pause) {
	if(_pause) {
		// Destroy All Menu Objects
		if(button_return) instance_destroy(button_return);
		
		is_paused = true;
	
		draw_x = camera_get_view_x(view_camera[0]) + 320;
		draw_y = camera_get_view_y(view_camera[0]) + 200;
		
		instance_deactivate_all(true);
	
		button_return = instance_create_layer(draw_x, draw_y + 50, "Game_Controller", o_button_return);
		button_return.depth = depth - 1;
	} else {
		instance_activate_all();
		is_paused = false;
	}
}