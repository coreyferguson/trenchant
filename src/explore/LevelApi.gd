extends Node

signal level_changed

var level = 0 setget set_level

func set_level(new_level):
	level = new_level
	emit_signal("level_changed", new_level)

func reset_state():
	level = 0
