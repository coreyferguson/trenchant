extends Sprite

var PostBuildResource = preload("../env/SheepFarm.tscn")
var SheepDog = preload('../env/sheep_dog/SheepDog.tscn')

func _process(delta):
	global_position = get_global_mouse_position()

func _unhandled_input(event):
	if Game.is_input_disabled: return
	if event.is_action_pressed("use_1"):
		# build sheep farm
		Inventory.remove(Build.builds['sheep_farm'].resource_requirements)
		var farm = PostBuildResource.instance()
		farm.global_position = get_global_mouse_position()
		Env.add(farm)
		# cleanup
		get_tree().set_input_as_handled()
		queue_free()
	if event.is_action_pressed("cancel"):
		queue_free()
