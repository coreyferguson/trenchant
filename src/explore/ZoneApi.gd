extends Node

signal zones_to_explore_changed

var zones = {
	'forest': {
		'name': 'forest',
		'icon': preload("./zones/Forest/Forest.png"),
		'scene': preload("./zones/Forest/Forest.tscn"),
	}
}

var zones_to_explore = []
var HOME = 'home'
var current_zone = HOME

func _ready():
	reset_state()

func reset_state():
	zones_to_explore = []
	zones_to_explore.resize(4)
	current_zone = HOME
	generate_new_zones()

func generate_new_zones():
	for i in range(zones_to_explore.size()):
		randomize()
		var zone_keys = zones.keys()
		var zone_key_to_explore = zone_keys[randi()%zone_keys.size()]
		zones_to_explore[i] = zones[zone_key_to_explore]
	emit_signal("zones_to_explore_changed")

func is_home():
	return current_zone == HOME

func go_to_available_zone(index):
	if !zones_to_explore[index]: return
	Game.is_input_disabled = true
	current_zone = zones_to_explore[index].name
	zones_to_explore[index] = null
	var has_more_zones = false
	for i in range(zones_to_explore.size()):
		if zones_to_explore[i]:
			has_more_zones = true
			break
	if !has_more_zones: generate_new_zones()
	Env.fade_out()
	yield(Env, 'fade_finished')
	Game.change_scene('environment')

func go_home():
	current_zone = HOME
	Game.change_scene('environment')

func spawn():
	Env.add(zones[current_zone].scene.instance())
