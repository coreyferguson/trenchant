extends Node

var groups = {
	'OneBearChicken': {
		'name': 'OneBearChicken',
		'scene': preload('./groups/OneBearChicken/OneBearChicken.tscn'),
		'minimum_level': 5
	},
}

func spawn():
	randomize()
	var groups = get_groups_in_level()
	if groups.size() > 0:
		var rand_index = randi() % groups.size()
		var rand_group_scene = groups[rand_index].scene
		Env.add(rand_group_scene.instance())

func get_groups_in_level():
	var groups_in_level = []
	var group_keys = groups.keys()
	for i in range(group_keys.size()):
		if groups[group_keys[i]].minimum_level <= Level.level:
			groups_in_level.push_back(groups[group_keys[i]])
	return groups_in_level
	
