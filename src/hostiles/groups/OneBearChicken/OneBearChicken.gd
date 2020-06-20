extends Node2D

var BearChickenScene = preload('../../BearChicken/BearChicken.tscn')

func _ready():
	var inst = BearChickenScene.instance()
	inst.global_position = Game.get_random_spawn_position()
	Env.add(inst)
