tool
extends VBoxContainer

signal pressed

export(Texture) var icon setget set_icon
export(String) var label setget set_label
export(PackedScene) var BuildResource

func set_icon(new_icon):
	icon = new_icon
	if has_node("container/button/icon"): $container/button/icon.texture = new_icon

func set_label(new_label):
	label = new_label
	if has_node("panel/label"): $panel/label.text = new_label

func _on_button_pressed():
	emit_signal("pressed")
	if BuildResource: Env.add(BuildResource.instance())
