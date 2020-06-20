extends Node2D

var ExploreContainer = preload("res://src/environment/ExploreContainer.tscn")
var GoHomeZone = preload("res://src/explore/GoHomeZone.tscn")

func _ready():
	Env.fade_in()
	yield(Env, 'fade_finished')
	if Zone.is_home():
		Level.level += 1
		$HUD.add_child(ExploreContainer.instance())
		Env.restore_persisted_nodes()
		Hostile.spawn()
	else:
		$container.add_child(GoHomeZone.instance())
		Zone.spawn()
	Game.is_input_disabled = true
	$player.play_enter_zone_animation()
	yield($player, "play_enter_zone_animation_finished")
	Game.is_input_disabled = false
