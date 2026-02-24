switch(state) {
	case STATE.GROUND:
		player_ground();
	break;
	
	case STATE.HOOKING:
		player_hooking();
	break;
	
	case STATE.HOOK_FALL:
		player_hook_fall();
	break;
	
	case STATE.FALLING:
		player_falling();
	break;
}

camera_set_view_pos(view_camera[0], 640 * int64(x / 640), 368 * int64(y / 368) + 4);