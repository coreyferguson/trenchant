extends Node2D

var Tree = preload('res://src/game/resources/tree/Tree.tscn')

func _ready():
	randomize()
	spawn_trees()

func spawn_trees():
	var tree = Tree.instance()
	tree.global_position = Game.get_random_spawn_position()
	Env.add(tree)

