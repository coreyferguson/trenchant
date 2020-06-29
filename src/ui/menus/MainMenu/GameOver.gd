extends Node2D

func _ready():
	$canvas/center/vbox/center/level/value.text = str(Level.level)

func _on_restart_game_pressed():
	Game.reset_state()
	Game.change_scene('environment')
