tool
extends VBoxContainer

export(Texture) var icon setget set_icon
export(int) var quantity setget set_quantity

func set_icon(new_icon):
	icon = new_icon
	if has_node("button/icon"): $button/icon.texture = new_icon

func set_quantity(new_quantity):
	quantity = new_quantity
	if has_node("panel/quantity"): $panel/quantity.text = str(new_quantity)
