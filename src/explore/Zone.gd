tool
extends MarginContainer

signal pressed

export(Texture) var icon setget set_icon

func set_icon(new_icon):
	icon = new_icon
	if has_node("button/icon"): $button/icon.texture = new_icon

func _on_button_pressed():
	emit_signal("pressed")
