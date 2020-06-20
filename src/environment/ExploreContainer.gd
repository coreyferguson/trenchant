tool
extends CenterContainer

func _ready():
	if Engine.editor_hint:
		modulate = Color(1, 1, 1, 1)
	else:
		$animation.play("fade_in")
