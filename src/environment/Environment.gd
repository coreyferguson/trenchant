extends Node2D

var ExploreView = preload("res://src/explore/ExploreView.tscn")
var home_background = preload("res://src/explore/zones/Forest/background.png")

func _ready():
	if Zone.is_home(): 
		Env.restore_persisted_nodes()
		$background.texture = home_background
	else:
		$background.texture = Zone.zones[Zone.current_zone].background
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
