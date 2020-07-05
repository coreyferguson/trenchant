extends Node2D

var Tree = preload('res://src/game/resources/tree/Tree.tscn')
var min_trees_to_spawn = 1
var max_trees_to_spawn = 3

var Rock = preload('res://src/game/resources/rock/Rock.tscn')
var min_rocks_to_spawn = 1
var max_rocks_to_spawn = 1

var Sheep = preload("res://src/game/resources/sheep/Sheep.tscn")

func _ready():
	randomize()
	spawn_trees()
	spawn_rocks()
	spawn_sheep()

func spawn_trees():
	var max_minus_min = (max_trees_to_spawn - min_trees_to_spawn) + 1
	var trees_to_spawn = (randi() % max_minus_min) + min_trees_to_spawn
	for i in range(trees_to_spawn):
		var tree = Tree.instance()
		tree.global_position = Game.get_random_spawn_position()
		Env.add(tree)

func spawn_rocks():
	var max_minus_min = (max_rocks_to_spawn - min_rocks_to_spawn) + 1
	var rocks_to_spawn = (randi() % max_minus_min) + min_rocks_to_spawn
	for i in range(rocks_to_spawn):
		var rock = Rock.instance()
		rock.global_position = Game.get_random_spawn_position()
		Env.add(rock)

func spawn_sheep():
	if randi()%2 == 0:
		var sheep = Sheep.instance()
		sheep.global_position = Game.get_random_spawn_position()
		Env.add(sheep)
