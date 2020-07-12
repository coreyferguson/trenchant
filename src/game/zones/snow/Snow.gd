extends Node2D

var Sheep = preload("res://src/game/resources/sheep/Sheep.tscn")

func _ready():
	randomize()
	_spawn_sheep()

func _spawn_sheep():
	var inst = Sheep.instance()
	inst.global_position = Game.get_random_spawn_position()
	Env.add(inst)
