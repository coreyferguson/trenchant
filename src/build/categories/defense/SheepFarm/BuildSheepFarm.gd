extends Sprite

var PostBuildResource = preload("res://src/construction/SheepFarm/SheepFarm.tscn")

func _process(delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("interact"):
		Inventory.remove(Build.resource_requirements['sheep_farm'])
		var inst = PostBuildResource.instance()
		inst.global_position = get_global_mouse_position()
		Env.add(inst)
		queue_free()
	if Input.is_action_just_pressed("cancel"):
		queue_free()