extends PanelContainer

const SLOT = preload("res://Modules/inventory_module/inventory_scenes/inventory_slot.tscn")

@onready var item_grid = $MarginContainer2/MarginContainer/ItemGrid


func _input(_event):
	if Input.is_action_just_pressed("inventory") and get_tree().paused == false:
		visible = !visible

#func _ready() -> void:
	#var inv_data = preload("res://Assets/Items/inventory/test_inventory.tres")
	#populate_item_grid(inv_data.slot_datas)


func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data)

func  populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in inventory_data.slot_datas:
		var slot = SLOT.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		
		if slot_data:
			slot.set_slot_data(slot_data)
