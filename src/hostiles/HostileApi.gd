extends Node

var camps = {
	'Goblins': {
		'name': 'Goblins',
		'scene': preload('./camps/Goblins/Goblins.tscn'),
		'minimum_level': 2
	},
	'OneBearChicken': {
		'name': 'OneBearChicken',
		'scene': preload('./camps/OneBearChicken/OneBearChicken.tscn'),
		'minimum_level': 5
	},
}

var raids = {
}

func spawn():
	randomize()
	var groups
	if Zone.current_zone != Zone.HOME: groups = get_camps_in_level()
	else: groups = get_raids_in_level()
	if groups.size() > 0:
		var rand_index = randi() % groups.size()
		var rand_group_scene = groups[rand_index].scene
		Env.add(rand_group_scene.instance())

func get_camps_in_level():
	var camps_in_level = []
	var group_keys = camps.keys()
	for i in range(group_keys.size()):
		if camps[group_keys[i]].minimum_level <= Level.level:
			camps_in_level.push_back(camps[group_keys[i]])
	return camps_in_level

func get_raids_in_level():
	var raids_in_level = []
	var group_keys = raids.keys()
	for i in range(group_keys.size()):
		if raids[group_keys[i]].minimum_level <= Level.level:
			raids_in_level.push_back(raids[group_keys[i]])
	return raids_in_level
	
