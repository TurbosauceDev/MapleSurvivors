extends CanvasLayer

@onready var pause_menu = $"."
@onready var OptionMenu = get_tree().get_nodes_in_group("Options")
@onready var MainMenu = preload("res://Scenes/levels/main_menu.tscn")

func _ready():
	pause_menu.hide()
	get_tree().call_group("Options", "hide")

func _on_resume_pressed():
	hide()
	get_tree().call_group("Options", "hide")
	get_tree().paused = !get_tree().paused

func _on_options_pressed():
	get_tree().call_group("Options", "ToggleOptions")

func _on_quit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene_to_packed(MainMenu)
