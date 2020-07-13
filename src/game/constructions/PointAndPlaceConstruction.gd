tool
extends Node2D

export(String) var construction_name setget _set_construction_name

func _process(delta):
	global_position = get_global_mouse_position()

func _set_construction_name(new_construction_name):
	construction_name = new_construction_name
	$sprite.texture = Construction.constructions[construction_name].texture

func _unhandled_input(event):
	if Game.is_input_disabled: return
	if event.is_action_pressed('use_1'):
		Inventory.remove(Build.builds[construction_name].resource_requirements)
		var instance = Construction.constructions[construction_name].scene.instance()
		instance.global_position = get_global_mouse_position()
		Env.add(instance)
		get_tree().set_input_as_handled()
		queue_free()
	if event.is_action_pressed("cancel"):
		queue_free()
