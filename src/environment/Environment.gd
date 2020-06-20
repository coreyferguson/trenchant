extends Node2D

var ExploreContainer = preload("res://src/environment/ExploreContainer.tscn")
var GoHomeZone = preload("res://src/explore/GoHomeZone.tscn")

func _ready():
	if Zone.is_home():
		Level.level += 1
		$HUD.add_child(ExploreContainer.instance())
		Env.restore_persisted_nodes()
		Hostile.spawn()
	else:
		$container.add_child(GoHomeZone.instance())
		Zone.spawn()
	$player.play_enter_zone_animation()
