extends Button

@export var action : String = "ui_up"

func _ready():
	set_process_unhandled_key_input(false)
	display_key()

func display_key():
	text = InputMap.action_get_events(action)[0].as_text()

func remap_action_to(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	
	#SaveSettings.config.set_value("Controls", action, event)
	#SaveSettings.save_data()

func _on_pressed():
	set_process_unhandled_key_input(true)
	text = "press any key"

func _unhandled_key_input(event):
	remap_action_to(event)
	set_process_unhandled_key_input(false)
	release_focus()
