extends Node

var items = {
	'wood': { 'icon': preload("res://src/items/Wood/Wood.png") }
}

func get(name):
	if !items.has(name): return { 'icon': preload("res://src/items/Unknown.png") }
	return items[name]
