extends CanvasLayer

@onready var pause_menu = $PauseMenu
@onready var OptionMenu = get_tree().get_nodes_in_group("Options")
#@onready var inventory_controller = $InventoryController
@onready var player = get_parent()



func _ready() -> void:
	#inventory_controller.set_player_inventory_data(player.inventory_data)
	pass

func _input(_event):
	pass

func pausegame():
	pause_menu.visible = !pause_menu.visible
	get_tree().call_group("Options", "hide")
	get_tree().paused = !get_tree().paused
