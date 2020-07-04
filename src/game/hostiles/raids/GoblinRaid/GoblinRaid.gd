extends Node2D

signal hostiles_neutralized

var GoblinSelfishBehavior = preload("../../Goblin/GoblinSelfishBehavior.tscn")

onready var timer = $timer
onready var goblins_container = $goblins_container
onready var middle_goblin = $goblins_container/goblin2
onready var follow_player_timer = $follow_player_timer

func _ready():
	var goblins = goblins_container.get_children()
	middle_goblin.connect('arrived_at_target_position', self, '_on_goblin_arrived_at_target_position')
	for i in range(goblins.size()):
		goblins[i].look_left()
		goblins[i].move_to(goblins[i].global_position - Vector2(600, 0))
		goblins[i].connect('killed', self, '_on_goblin_killed')

func _on_close_range_body_entered(body):
	_switch_to_selfish_behavior()

func _on_goblin_arrived_at_target_position():
	follow_player_timer.start()
	middle_goblin.disconnect('arrived_at_target_position', self, '_on_goblin_arrived_at_target_position')
	timer.connect('timeout', self, '_on_timer_timeout')
	timer.start()
	_on_timer_timeout()

func _on_goblin_killed():
	_switch_to_selfish_behavior()

func _on_timer_timeout():
	var goblins = goblins_container.get_children()
	for i in range(goblins.size()): 
		goblins[i].shoot_left()

func _switch_to_selfish_behavior():
	# disconnect existing signals
	follow_player_timer.stop()
	var goblins = goblins_container.get_children()
	for i in range(goblins.size()):
		goblins[i].disconnect('killed', self, '_on_goblin_killed')
	timer.disconnect('timeout', self, '_on_timer_timeout')
	# replace goblins with selfish-goblins
	for i in range(goblins.size()):
		if !goblins[i].health: continue
		var new_goblin = GoblinSelfishBehavior.instance()
		goblins_container.add_child(new_goblin)
		new_goblin.global_position = goblins[i].global_position
		new_goblin.health = goblins[i].health
		goblins[i].queue_free()

func _on_follow_player_timer_timeout():
	var delta_y = Env.get_player().global_position.y - middle_goblin.global_position.y
	var goblins = goblins_container.get_children()
	for i in range(goblins.size()):
		goblins[i].move_to(goblins[i].global_position + Vector2(0, delta_y))

func _on_hostiles_neutralized_timer_timeout():
	if goblins_container.get_child_count() == 0:
		emit_signal("hostiles_neutralized")
		queue_free()
