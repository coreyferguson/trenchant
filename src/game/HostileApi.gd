extends Node

signal hostiles_neutralized

var are_hostiles_neutralized = false

var camps = {
	'Goblins': {
		'name': 'Goblins',
		'scene': preload('./hostiles/camps/Goblins/Goblins.tscn'),
		'minimum_level': 2
	},
	'Rhinos': {
		'name': 'Rhinos',
		'scene': preload('./hostiles/camps/Rhinos/Rhinos.tscn'),
		'minimum_level': 2,
	}
}

var raids = {
	'GoblinRaid': {
		'name': 'GoblinRaid',
		'scene': preload("./hostiles/raids/GoblinRaid/GoblinRaid.tscn"),
		'minimum_level': 3
	}
}

func spawn():
	randomize()
	var groups
	if Zone.current_zone != Zone.HOME: groups = get_camps_in_level()
	else: groups = get_raids_in_level()
	are_hostiles_neutralized = false
	if groups.size() > 0:
		var rand_index = randi() % groups.size()
		var Scene = groups[rand_index].scene
		var scene = Scene.instance()
		Env.add(scene)
		if scene.has_signal('hostiles_neutralized'):
			yield(scene, 'hostiles_neutralized')
	are_hostiles_neutralized = true
	emit_signal('hostiles_neutralized')

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
	
