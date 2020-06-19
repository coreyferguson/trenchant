extends VBoxContainer

func _process(delta):
	if Input.is_action_pressed("cancel"): hide_all_category_slots()

func _on_selected_build_category_light():
	hide_all_category_slots()
	$light_category.visible = true

func hide_all_category_slots():
	$light_category.visible = false
	
