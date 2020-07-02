extends Node

var items = {
	'bow': {
		'icon': preload("res://src/build/categories/weapon/bow_icon.png"),
		'useable': {
			'scene': preload("res://src/items/Bow/UseBow.tscn"),
			'scene_instance_delay_in_seconds': 0.6,
			'use_again_delay_in_seconds': 3,
		}
	},
	'fist': {
		'icon': preload("./Fist/Fist.png"),
		'useable': {
			'scene': preload("res://src/items/Fist/UseFist.tscn"),
			'scene_instance_delay_in_seconds': 0.2,
			'use_again_delay_in_seconds': 0.5,
		}
	},
	'obsidian': { 'icon': preload("./Obsidian/obsidian_icon.png") },
	'rock': { 'icon': preload("./Rock/Rock.png") },
	'sheep': { 'icon': preload("./Sheep/Sheep.png") },
	'spear': {
		'icon': preload('res://src/build/categories/weapon/spear_icon.png'),
		'useable': {
			'scene': preload("res://src/items/Spear/UseSpear.tscn"),
			'scene_instance_delay_in_seconds': 0.3,
			'use_again_delay_in_seconds': 2,
		}
	},
	'stick': { 'icon': preload("./Stick/Stick.png") },
	'wood': { 'icon': preload("./Wood/Wood.png") },
}

func get(name):
	if !items.has(name): return { 'icon': preload("res://src/items/Unknown.png") }
	return items[name]
