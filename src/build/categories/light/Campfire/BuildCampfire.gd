extends Node2D

var CampfireResource = preload("res://src/construction/Campfire/Campfire.tscn")

func _process(delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("interact"):
		Inventory.remove(Build.resource_requirements['campfire'])
		var campfire = CampfireResource.instance()
		campfire.global_position = get_global_mouse_position()
		Env.add(campfire)
		queue_free()
	if Input.is_action_just_pressed("cancel"):
		queue_free()
