tool
extends HBoxContainer

export(Texture) var icon setget set_icon
export(int) var quantity setget set_quantity

func set_icon(new_icon):
	icon = new_icon
	$panel/icon.texture = icon

func set_quantity(new_quantity):
	quantity = new_quantity
	$quantity.text = str(quantity)
