extends Node

signal available_zones_changed

var zones = [
	{ 'name': 'forest', 'icon': preload("./zones/Forest.png") }
]

var available_zones = []
var HOME = 'home'
var current_zone = HOME

func _ready():
	available_zones.resize(4)
	generate_new_zones()

func generate_new_zones():
	for i in range(available_zones.size()):
		randomize()
		available_zones[i] = zones[randi()%zones.size()]
	emit_signal("available_zones_changed")

func is_home():
	return current_zone == HOME

func go_to_available_zone(index):
	current_zone = available_zones[index].name
	available_zones[index] = null
	var has_more_zones = false
	for i in range(available_zones.size()):
		if available_zones[i]:
			has_more_zones = true
			break
	if !has_more_zones: generate_new_zones()
	Game.change_scene('environment')

func go_home():
	current_zone = HOME
	Game.change_scene('environment')
