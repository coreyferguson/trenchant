extends Node

signal fade_out_screen_finished

var scenes = {
	'environment': 'res://src/game/environment/Environment.tscn',
	'game_over': 'res://src/ui/menus/game_over/GameOver.tscn',
	'main_menu': 'res://src/ui/menus/main_menu/MainMenu.tscn',
}

var is_input_disabled = false
var screen_size = Vector2(1920, 1080)

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

func get_random_offset_position(from_position, radius):
	randomize()
	var radiusX2 = radius * 2
	var rand_x = (randi()%radiusX2) + 1 - radius
	var rand_y = (randi()%radiusX2) + 1 - radius
	var rand_distance = (randi() % radius)
	var v = Vector2(rand_x, rand_y).normalized() * rand_distance
	return from_position + v

func get_random_circumference_position(from_position, radius):
	randomize()
	var radiusX2 = radius * 2
	var rand_x = (randi()%radiusX2) + 1 - radius
	var rand_y = (randi()%radiusX2) + 1 - radius
	var v = Vector2(rand_x, rand_y).normalized() * radius
	return from_position + v

func prune_weakref_array(weakrefs : Array):
	var indexes_to_delete = []
	for i in range(weakrefs.size()):
		if !weakrefs[i] || !weakrefs[i].get_ref(): 
			indexes_to_delete.push_back(i)
			continue
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		weakrefs.remove(indexes_to_delete[i])

func reset_state():
	Buffs.reset_state()
	Inventory.reset_state()
	Level.reset_state()
	Player.reset_state()
	Zone.reset_state()
