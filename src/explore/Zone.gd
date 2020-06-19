tool
extends MarginContainer

signal selected

export(Texture) var icon setget set_icon
var index

func set_icon(new_icon):
	icon = new_icon
	if has_node("button/icon"): $button/icon.texture = new_icon

func _on_button_pressed():
	emit_signal("selected", index)
