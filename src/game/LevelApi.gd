extends Node

signal level_changed

var level = 0 setget set_level

func is_exploring():
	# (1) = false
	# (2,3) = true
	# (4) = false
	# (5,6) = true
	# (7) = false
	# (8,9) = true
	return level%3 == 0 || (level+1)%3 == 0

func is_in_explore_cycle(cycle):
	# (2,3) = cycle 1
	# (5,6) = cycle 2
	# (8,9) = cycle 3
	if is_exploring():
		return floor((level+1)/3) == cycle
	return false

func set_level(new_level):
	level = new_level
	emit_signal("level_changed", new_level)

func reset_state():
	level = 0
