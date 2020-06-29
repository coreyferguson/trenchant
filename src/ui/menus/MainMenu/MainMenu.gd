extends Node2D

func _on_new_game_pressed():
	Game.reset_state()
	Game.change_scene('environment')
