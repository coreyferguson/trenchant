extends VBoxContainer

signal show_build_menu

var is_building = false

func _process(delta):
	if Input.is_action_just_pressed("build"): emit_signal("show_build_menu")


func _on_TextureButton_pressed():
	emit_signal("show_build_menu")
