if(variable_global_exists("pause") and global.pause) exit;

image_alpha -= 0.1;

if (image_alpha <= 0) instance_destroy();

x = camera_get_view_x(view_current);
y = camera_get_view_y(view_current);