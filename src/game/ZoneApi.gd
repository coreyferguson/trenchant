extends Node

signal zones_to_explore_changed

var zones = {
	'forest': {
		'background': preload("./zones/forest/background.png"),
		'name': 'forest',
		'icon': preload("./zones/forest/forest_icon.png"),
		'scene': preload("./zones/forest/Forest.tscn"),
	},
	'quarry': {
		'background': preload("./zones/quarry/background.png"),
		'name': 'quarry',
		'icon': preload('./zones/quarry/explore_icon.png'),
		'scene': preload('./zones/quarry/Quarry.tscn'),
	},
}

var zones_to_explore = []
var HOME = 'home'
var current_zone = HOME

func _ready():
	reset_state()

func is_home():
	return current_zone == HOME

func generate_new_zones():
	for i in range(zones_to_explore.size()):
		randomize()
		var zone_keys = zones.keys()
		var zone_key_to_explore = zone_keys[randi()%zone_keys.size()]
		zones_to_explore[i] = zones[zone_key_to_explore]
	emit_signal("zones_to_explore_changed")

func go_home():
	current_zone = HOME
	generate_new_zones()
	Game.change_scene('environment')

func go_to_available_zone(index):
	if !zones_to_explore[index]: return
	Game.is_input_disabled = true
	current_zone = zones_to_explore[index].name
	zones_to_explore[index] = null
	Game.change_scene('environment')

func has_more_zones():
	var zones_explored = 0
	for i in range(zones_to_explore.size()):
		if zones_to_explore[i] == null: zones_explored += 1
	return zones_explored < 2

func reset_state():
	zones_to_explore = []
	zones_to_explore.resize(4)
	current_zone = HOME
	generate_new_zones()

func spawn():
	if current_zone == HOME: return
	Env.add(zones[current_zone].scene.instance())
