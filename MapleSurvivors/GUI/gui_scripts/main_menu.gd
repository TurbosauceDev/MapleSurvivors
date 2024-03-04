extends Node2D
@export var Level : PackedScene = preload("res://Scenes/Levels/levels/level001.tscn")
#@export var ChooseLevel = preload(Level)
@onready var options_menu = $OptionsMenu
@onready var audio = $AudioStreamPlayer

func _ready():
	pass

func _input(_event):
	if Input.is_action_just_pressed("cancel"): 
		get_tree().call_group("Options", "hide")

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level000/level001.tscn")
	

func _on_options_pressed():
	options_menu.visible = !options_menu.visible

func _on_quit_game_pressed():
	get_tree().quit()
