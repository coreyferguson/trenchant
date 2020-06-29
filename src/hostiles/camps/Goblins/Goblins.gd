extends Node2D

var Goblin = preload("../../Goblin/Goblin.tscn")

func _ready():
	var goblins_to_spawn
	if Level.level <= 6: goblins_to_spawn = Level.level-1
	else: goblins_to_spawn = 6
	for i in range(goblins_to_spawn):
		var goblin = Goblin.instance()
		goblin.global_position = Game.get_random_spawn_position()
		Env.add(goblin)
