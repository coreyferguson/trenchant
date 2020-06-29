extends Node2D

var ExploreView = preload("res://src/explore/ExploreView.tscn")

func _ready():
	Env.fade_in()
	yield(Env, 'fade_finished')
	if Zone.is_home():
		Level.level += 1
		var explore_view = ExploreView.instance()
		Env.restore_persisted_nodes()
		Env.add(explore_view)
		Hostile.spawn()
	else:
#		$container.add_child(GoHomeZone.instance())
		Zone.spawn()
	Game.is_input_disabled = true
	$player.play_enter_zone_animation()
	yield($player, "play_enter_zone_animation_finished")
	Game.is_input_disabled = false
