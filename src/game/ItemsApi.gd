extends Node

var items = {
	'bow': {
		'icon': preload("./items/bow/build/bow_icon.png"),
		'useable': {
			'scene': preload("./items/bow/env/UseBow.tscn"),
			'scene_instance_delay_in_seconds': 0.6,
			'use_again_delay_in_seconds': 3,
		}
	},
	'fist': {
		'icon': preload("./items/fist/inventory/fist_icon.png"),
		'useable': {
			'scene': preload("./items/fist/env/UseFist.tscn"),
			'scene_instance_delay_in_seconds': 0.2,
			'use_again_delay_in_seconds': 0.5,
		}
	},
	'obsidian': { 'icon': preload("./items/obsidian/obsidian_icon.png") },
	'rock': { 'icon': preload("./items/rock/rock_icon.png") },
	'sheep': { 'icon': preload("./items/sheep/sheep_icon.png") },
	'spear': {
		'icon': preload('./items/spear/build/spear_icon.png'),
		'useable': {
			'rotate_sprite_node_path': 'bones/torso/arm_right/forearm_right/hand_right/fingers_right/spear',
			'scene': preload("./items/spear/env/UseSpear.tscn"),
			'scene_instance_delay_in_seconds': 0.3,
			'use_again_delay_in_seconds': 2,
		}
	},
	'stick': { 'icon': preload("./items/stick/stick_icon.png") },
	'wood': { 'icon': preload("./items/wood/wood_icon.png") },
}

func get(name):
	if !items.has(name): return { 'icon': preload("./items/unknown_icon.png") }
	return items[name]
