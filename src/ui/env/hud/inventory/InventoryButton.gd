extends VBoxContainer

signal pressed

func _on_button_pressed():
	emit_signal("pressed")
