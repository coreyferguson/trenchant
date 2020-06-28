tool
extends VBoxContainer

export(Texture) var icon setget set_icon
export(String) var trigger_string setget set_trigger_string

func set_icon(new_icon):
	icon = new_icon
	if has_node("button_container/button/icon"): 
		$button_container/button/icon.texture = new_icon

func set_trigger_string(new_trigger_string):
	trigger_string = new_trigger_string
	if has_node("panel/label"): 
		$panel/label.text = new_trigger_string
