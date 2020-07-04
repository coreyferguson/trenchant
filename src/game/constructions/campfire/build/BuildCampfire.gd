extends Node2D

var CampfireResource = preload("../env/Campfire.tscn")

func _process(delta):
	global_position = get_global_mouse_position()

func _unhandled_input(event):
	if Game.is_input_disabled: return
	if event.is_action_pressed('use_1'):
		Inventory.remove(Build.builds['campfire'].resource_requirements)
		var campfire = CampfireResource.instance()
		campfire.global_position = get_global_mouse_position()
		Env.add(campfire)
		get_tree().set_input_as_handled()
		queue_free()
	if event.is_action_pressed("cancel"):
		queue_free()
		
