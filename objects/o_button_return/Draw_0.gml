draw_self();

draw_set_font(f_pixel_12);
draw_set_colour(#644142);
draw_text_transformed(x - string_width("Return") / 2 * o_game.menu_scale, y - 9, "Return", o_game.menu_scale, 1, 0);