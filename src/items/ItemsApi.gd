extends Node

var items = {
	'rock': { 'icon': preload("./Rock/Rock.png") },
	'sheep': { 'icon': preload("./Sheep/Sheep.png") },
	'stick': { 'icon': preload("./Stick/Stick.png") },
	'wood': { 'icon': preload("./Wood/Wood.png") },
	'fist': {
		'icon': preload("./Fist/Fist.png"),
		'useable': {
			'scene': preload("res://src/items/Fist/UseFist.tscn"),
			'scene_instance_delay_in_seconds': 0.4,
			'use_again_delay_in_seconds': 1,
		}
	},
}

func get(name):
	if !items.has(name): return { 'icon': preload("res://src/items/Unknown.png") }
	return items[name]
