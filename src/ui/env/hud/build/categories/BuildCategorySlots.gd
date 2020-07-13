extends VBoxContainer

func _process(delta):
	if !Game.is_input_disabled && Input.is_action_pressed("cancel"): 
		hide_all_category_slots()

func _on_selected_build_category_construction():
	hide_all_category_slots()
	$construction_category.visible = true

func _on_selected_build_category_tool():
	hide_all_category_slots()
	$tool_category.visible = true

func hide_all_category_slots():
	$construction_category.visible = false
	$tool_category.visible = false
