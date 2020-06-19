extends Node2D

var Tree = preload("res://src/resources/Tree/Tree.tscn")
var min_trees_to_spawn = 3
var max_trees_to_spawn = 10

var Rock = preload("res://src/resources/Rock/Rock.tscn")
var min_rocks_to_spawn = 3
var max_rocks_to_spawn = 10

func _ready():
	randomize()
	spawn_trees()
	spawn_rocks()

func spawn_trees():
	var min_plus_max = min_trees_to_spawn + max_trees_to_spawn
	var trees_to_spawn = randi() % min_plus_max + min_trees_to_spawn + 1
	for i in range(trees_to_spawn):
		var tree = Tree.instance()
		tree.global_position = Game.get_random_spawn_position()
		Env.add(tree)
	
func spawn_rocks():
	var min_plus_max = min_rocks_to_spawn + max_rocks_to_spawn
	var rocks_to_spawn = randi() % min_plus_max + min_rocks_to_spawn + 1
	for i in range(rocks_to_spawn):
		var rock = Rock.instance()
		rock.global_position = Game.get_random_spawn_position()
		Env.add(rock)
	
