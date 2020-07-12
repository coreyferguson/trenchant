extends Node2D

var Obsidian = preload('res://src/game/resources/obsidian/Obsidian.tscn')
var Rock = preload("res://src/game/resources/rock/Rock.tscn")

func _ready():
	randomize()
	_spawn_obsidian()

func _spawn_obsidian():
	var obsidian = Obsidian.instance()
	obsidian.global_position = Game.get_random_spawn_position()
	Env.add(obsidian)
	var rock = Rock.instance()
	rock.global_position = Game.get_random_spawn_position()
	Env.add(rock)
