if(is_paused) {
	if(pause_timer++ >= pause_time) {
		pause_timer = pause_time;
	}
} else {
	if(pause_timer-- <= 0) {
		pause_timer = 0
	}
}

menu_scale = pause_timer / pause_time;