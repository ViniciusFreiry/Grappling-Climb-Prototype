if(instance_exists(obj_player) and bbox_top >= obj_player.bbox_bottom) {
	var _bridge = instance_create_layer(x, y, "Instances", obj_solid_bridge);
	
	_bridge.image_xscale = image_xscale;
	_bridge.image_yscale = image_yscale;
	
	instance_destroy();
}