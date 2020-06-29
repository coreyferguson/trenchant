extends Node2D

var ExploreView = preload("res://src/explore/ExploreView.tscn")

func _ready():
	if Zone.is_home(): Env.restore_persisted_nodes()
	Level.level += 1
	Env.add(ExploreView.instance())
	Zone.spawn()
	Hostile.spawn()
	Env.fade_in()
	yield(Env, 'fade_finished')
	Game.is_input_disabled = true
	$player.play_enter_zone_animation()
	yield($player, "play_enter_zone_animation_finished")
	Game.is_input_disabled = false
