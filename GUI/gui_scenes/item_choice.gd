extends Control

@onready var name_label = $item_button/name_label
@onready var desc_label = $item_button/desc_label
@onready var level_label = $item_button/level_label
@onready var item_btn_texture = $item_button/item_btn_panel/item_btn_texture


var item = null
@onready var player = get_tree().get_first_node_in_group("player")


signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null:
		item = "slime_candy_green"
	name_label.text = UpgradeDb.UPGRADES[item]["displayname"]
	desc_label.text = UpgradeDb.UPGRADES[item]["details"]
	level_label.text = UpgradeDb.UPGRADES[item]["level"]
	item_btn_texture.texture = load(UpgradeDb.UPGRADES[item]["icon"])

func _on_item_button_pressed():
	emit_signal("selected_upgrade", item)
	print("Button Pressed")
