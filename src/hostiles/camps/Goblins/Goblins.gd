extends Node2D

signal hostiles_neutralized

var Goblin = preload("../../Goblin/Goblin.tscn")
var goblins = []

func _ready():
	var goblins_to_spawn
	if Level.level <= 6: goblins_to_spawn = Level.level-1
	else: goblins_to_spawn = 6
	for i in range(goblins_to_spawn):
		var goblin = Goblin.instance()
		goblin.global_position = Game.get_random_spawn_position()
		Env.add(goblin)
		goblins.push_back(weakref(goblin))

func _on_Timer_timeout():
	var indexes_to_delete = []
	for i in range(goblins.size()):
		if !goblins[i].get_ref(): 
			indexes_to_delete.push_back(i)
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		goblins.remove(indexes_to_delete[i])
	if goblins.size() == 0: emit_signal("hostiles_neutralized")
