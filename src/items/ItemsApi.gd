extends Node

var items = {
	'rock': { 'icon': preload("res://src/items/Rock/Rock.png") },
	'stick': { 'icon': preload("res://src/items/Stick/Stick.png") },
	'wood': { 'icon': preload("res://src/items/Wood/Wood.png") },
}

func get(name):
	if !items.has(name): return { 'icon': preload("res://src/items/Unknown.png") }
	return items[name]
