extends Control

@onready var INPUT_BUTTON = preload("res://GUI/gui_scenes/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/ScrollContainer/ActionList

var is_remapping : bool = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"up" : "Portal / Climb Ladder", 
	"left" : "Move Left",
	"down" : "Duck",
	"right" : "Move Right",
	"jump" : "Jump",
	"cancel" : "Pause Game / Close Menu / Cancel",
	"accept" : "Accept",
	"quit" : "Quit Game",
	"character" : "Character Panel",
	"skills" : "Abilities",
	"talents" : "Talents",
	"inventory" : "Inventory",
	"equipment" : "Equipment",
	"quests" : "Quest Log",
	"bestiary" : "Bestiary",
	"bar1" : "Action Bar 1",
	"bar2" : "Action Bar 2",
	"bar3" : "Action Bar 3",
	"bar4" : "Action Bar 4",
	"bar5" : "Action Bar 5",
	"bar6" : "Action Bar 6",
	"bar7" : "Action Bar 7",
	"bar8" : "Action Bar 8",
 }

func _ready():
	_create_action_list()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = INPUT_BUTTON.instantiate()
		var action_label = button.find_child("ActionLabel")
		var input_label = button.find_child("InputLabel")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("InputLabel").text = "Press key to bind..."

func _input(event):
	if is_remapping:
		if (event is InputEventKey|| (event is InputEventMouseButton && event.pressed)):
			if event is InputEventMouseButton: 
				return
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()

func _update_action_list(button, event):
	button.find_child("InputLabel").text = event.as_text().trim_suffix(" (Physical)")

func _on_reset_button_pressed():
	_create_action_list()
