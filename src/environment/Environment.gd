extends Node2D

var ExploreContainer = preload("res://src/environment/ExploreContainer.tscn")
var GoHomeZone = preload("res://src/explore/GoHomeZone.tscn")

func _ready():
	if Zone.is_home():
		$HUD.add_child(ExploreContainer.instance())
	else:
		$container.add_child(GoHomeZone.instance())
	$player.play_enter_zone_animation()
