extends VBoxContainer

export(Resource) var icon setget set_icon
export(String) var label setget set_label
export(int) var quantity setget set_quantity

var is_mouse_over_slot = false

func _input(event):
	if !label: return
	if !is_mouse_over_slot: return
	if !Items.items[label].has('useable'): return
	if Input.is_action_just_pressed("use_1"):
		Inventory.set_belt_slot(0, { 'name': label })
		get_tree().set_input_as_handled()
	if Input.is_action_just_pressed("use_2"):
		Inventory.set_belt_slot(1, { 'name': label })
		get_tree().set_input_as_handled()
	if Input.is_action_just_pressed("use_3"):
		Inventory.set_belt_slot(2, { 'name': label })
		get_tree().set_input_as_handled()
	if Input.is_action_just_pressed("use_4"):
		Inventory.set_belt_slot(3, { 'name': label })
		get_tree().set_input_as_handled()

func set_icon(new_icon):
	icon = new_icon
	$button_container/button/icon.texture = icon

func set_label(new_label):
	label = new_label
	$label_container/hbox/label.text = label

func set_quantity(new_quantity):
	quantity = new_quantity
	if quantity == null: $label_container/hbox/quantity.text = ""
	else: $label_container/hbox/quantity.text = str(quantity)

func _on_button_mouse_entered():
	is_mouse_over_slot = true

func _on_button_mouse_exited():
	is_mouse_over_slot = false

