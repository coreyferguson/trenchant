extends Node2D

var Sheep = preload("res://src/game/resources/sheep/Sheep.tscn")
var min_sheep_to_spawn = 1
var max_sheep_to_spawn = 2

func _ready():
	randomize()
	_spawn_sheep()

func _spawn_sheep():
	var max_minus_min = max_sheep_to_spawn - min_sheep_to_spawn + 1
	var num_to_spawn = randi()%max_minus_min + min_sheep_to_spawn
	for i in range(num_to_spawn):
		var inst = Sheep.instance()
		inst.global_position = Game.get_random_spawn_position()
		Env.add(inst)
