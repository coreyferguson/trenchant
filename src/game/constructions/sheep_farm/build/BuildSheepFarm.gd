extends Sprite

var PostBuildResource = preload("../env/SheepFarm.tscn")

func _process(delta):
	global_position = get_global_mouse_position()
	if Game.is_input_disabled: return
	if Input.is_action_just_pressed("interact"):
		Inventory.remove(Build.resource_requirements['sheep_farm'])
		var inst = PostBuildResource.instance()
		inst.global_position = get_global_mouse_position()
		Env.add(inst)
		queue_free()
	if Input.is_action_just_pressed("cancel"):
		queue_free()
