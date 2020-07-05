extends Node2D

var Obsidian = preload('res://src/game/resources/obsidian/Obsidian.tscn')
var min_obsidian_to_spawn = 1
var max_obsidian_to_spawn = 2

var Rock = preload('res://src/game/resources/rock/Rock.tscn')
var min_rocks_to_spawn = 1
var max_rocks_to_spawn = 3

func _ready():
	randomize()
	_spawn_obsidian()
	_spawn_rocks()

func _spawn_obsidian():
	var max_minus_min = max_obsidian_to_spawn - min_obsidian_to_spawn + 1
	var num_to_spawn = randi()%max_minus_min + min_obsidian_to_spawn
	for i in range(num_to_spawn):
		var inst = Obsidian.instance()
		inst.global_position = Game.get_random_spawn_position()
		Env.add(inst)

func _spawn_rocks():
	var max_minus_min = (max_rocks_to_spawn - min_rocks_to_spawn) + 1
	var rocks_to_spawn = (randi() % max_minus_min) + min_rocks_to_spawn
	for i in range(rocks_to_spawn):
		var rock = Rock.instance()
		rock.global_position = Game.get_random_spawn_position()
		Env.add(rock)
