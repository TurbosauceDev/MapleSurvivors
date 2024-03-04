extends Node

const PATH = "user://settings.cfg"
var config = ConfigFile.new()

func _ready():
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() !=0:
			config.set_value("Controls" , action , InputMap.action_get_events(action)[0])
	
	load_data()

func save_data():
	config.save(PATH)

func load_data():
	if config.load("user://settings.cfg") != OK:
		save_data()
		return
	
	load_control_settings()

func load_control_settings():
	var keys = config.get_section_keys("Controls")
	
	for action in InputMap.get_actions():
		if keys.has(action):
			var value = config.get_value("Controls", action)
	
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, value)
