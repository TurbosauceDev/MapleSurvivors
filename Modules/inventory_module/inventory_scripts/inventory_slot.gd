extends PanelContainer


signal slot_clicked(index: int, button: int)

@onready var textures = $MarginContainer/TextureRect
@onready var labels = $QuantityLabel



func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	textures.texture = item_data.texture
	tooltip_text = "%s/n%s" % [item_data.name, item_data.description]
	
	if slot_data.quantity > 1:
		labels.text = " x%s" % slot_data.quantity
		labels.show()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
