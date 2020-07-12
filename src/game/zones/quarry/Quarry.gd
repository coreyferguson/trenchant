extends Node2D

var Obsidian = preload('res://src/game/resources/obsidian/Obsidian.tscn')

func _ready():
	randomize()
	_spawn_obsidian()

func _spawn_obsidian():
	var inst = Obsidian.instance()
	inst.global_position = Game.get_random_spawn_position()
	Env.add(inst)
