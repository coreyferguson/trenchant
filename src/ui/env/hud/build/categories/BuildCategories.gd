extends HBoxContainer

func _process(delta):
	if !Game.is_input_disabled && visible && Input.is_action_pressed("cancel"):
		visible = false

func _on_build_show_build_menu():
	visible = true
