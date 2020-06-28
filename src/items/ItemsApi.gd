extends Node

var items = {
	'rock': { 'icon': preload("./Rock/Rock.png") },
	'sheep': { 'icon': preload("./Sheep/Sheep.png") },
	'stick': { 'icon': preload("./Stick/Stick.png") },
	'wood': { 'icon': preload("./Wood/Wood.png") },
}

func get(name):
	if !items.has(name): return { 'icon': preload("res://src/items/Unknown.png") }
	return items[name]
