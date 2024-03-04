extends TabBar


func _on_fullscreen_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_box_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)


func _on_v_sync_option_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)
	#print(DisplayServer.window_get_vsync_mode())
