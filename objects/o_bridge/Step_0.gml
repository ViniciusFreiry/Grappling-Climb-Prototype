if(bbox_top >= o_player.bbox_bottom) {
	var _bridge = instance_create_layer(x, y, "Instances", o_solid_bridge);
	
	_bridge.image_xscale = image_xscale;
	_bridge.image_yscale = image_yscale;
	
	instance_destroy();
}