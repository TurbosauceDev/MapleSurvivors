#extends GUI
extends Button

@onready var pause_menu = $GUIController/GUILayer/PauseMenu
@onready var options_menu = $GUIController/GUILayer/OptionsMenu


func _on_pressed():
	resumegame()
	#pass

func resumegame():
	pause_menu.hide()
	get_tree().paused = !get_tree().paused
