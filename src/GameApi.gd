extends Node

var scenes = {
	'environment': 'res://src/environment/Environment.tscn'
}

func change_scene(scene : String):
	return get_tree().change_scene(scenes[scene])

func get_random_spawn_position():
	var min_x = 100
	var max_x = 1820
	var min_y = 100
	var max_y = 980
	randomize()
	var x = (randi() % (max_x - min_x)) + min_x
	var y = (randi() % (max_y - min_y)) + min_y
	return Vector2(x, y)
