extends Node2D

signal hostiles_neutralized

var Rhino = preload('../../Rhino/Rhino.tscn')
var rhinos = []

func _ready():
	randomize()
	var num_to_spawn
	if Level.is_in_explore_cycle(1): num_to_spawn = 1
	elif Level.is_in_explore_cycle(2): num_to_spawn = 2
	else: num_to_spawn = 3
	var rhino = Rhino.instance()
	rhino.global_position = Game.get_random_spawn_position()
	Env.add(rhino)
	rhinos.push_back(weakref(rhino))

func _on_hostiles_neutralized_timer_timeout():
	Game.prune_weakref_array(rhinos)
	if rhinos.size() == 0: emit_signal("hostiles_neutralized")

