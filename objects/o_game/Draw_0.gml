if(pause_timer > 0) {
	draw_x = camera_get_view_x(view_camera[0]) + 320;
	draw_y = camera_get_view_y(view_camera[0]) + 200;
	
	// Banner
	draw_sprite_ext(s_banner, 0, draw_x, draw_y - 82, menu_scale, 1, 0, c_white, 1);
	draw_set_font(f_pixel_24);
	draw_set_colour(#644142);
	draw_text_transformed(draw_x - string_width("Pause Menu") / 2 * menu_scale, draw_y - 114, "Pause Menu", menu_scale, 1, 0);
	
	// Book
	draw_sprite_ext(s_cover, 0, draw_x, draw_y, menu_scale, 1, 0, c_white, 1);
	draw_sprite_ext(s_page_left, 0, draw_x, draw_y, menu_scale, 1, 0, c_white, 1);
	draw_sprite_ext(s_page_right, 0, draw_x, draw_y, menu_scale, 1, 0, c_white, 1);
	
	// Buttons
	if(button_return) {
		button_return.image_xscale = menu_scale;
		button_return.x = draw_x + (69 * menu_scale);
	}
} else {
	if(button_return) {
		instance_destroy(button_return);
		button_return = noone;
	}
}