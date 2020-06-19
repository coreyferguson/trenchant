extends Node2D

var Tree = preload("res://src/resources/Tree/Tree.tscn")
var min_trees_to_spawn = 3
var max_trees_to_spawn = 10

func _ready():
	randomize()
	var min_plus_max = min_trees_to_spawn + max_trees_to_spawn
	var trees_to_spawn = randi() % min_plus_max + min_trees_to_spawn + 1
	for i in range(trees_to_spawn):
		var tree = Tree.instance()
		tree.global_position = Game.get_random_spawn_position()
		Env.add(tree)
