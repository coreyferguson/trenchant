tool
extends Area2D

signal trigger

export(int) var zone_index
export(Resource) var icon setget set_icon

func _on_area_body_entered(body):
	emit_signal("trigger", zone_index)

func set_icon(new_icon):
	icon = new_icon
	if has_node("icon"): $icon.texture = new_icon
