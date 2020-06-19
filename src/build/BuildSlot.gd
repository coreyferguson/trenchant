tool
extends VBoxContainer

signal pressed

export(String) var label setget set_label
export(Texture) var icon setget set_icon
export(String) var construction_name
export(PackedScene) var BuildResource

var has_resources = false

func _ready():
	update_required_resources_state()
	Inventory.connect("item_added_to_belt", self, '_on_item_added_to_belt')
	Inventory.connect("item_added_to_backpack", self, '_on_item_added_to_backpack')
	Inventory.connect("item_removed_from_belt", self, '_on_item_removed_from_belt')
	Inventory.connect("item_removed_from_backpack", self, '_on_item_removed_from_backpack')

func set_icon(new_icon):
	icon = new_icon
	if has_node("container/button/icon"): $container/button/icon.texture = new_icon

func set_label(new_label):
	label = new_label
	if has_node("panel/label"): $panel/label.text = new_label

func _on_button_pressed():
	emit_signal("pressed")
	if BuildResource && has_resources: Env.add(BuildResource.instance())

func _on_item_added_to_belt(index):
	update_required_resources_state()

func _on_item_added_to_backpack(index):
	update_required_resources_state()
	
func _on_item_removed_from_belt(index):
	update_required_resources_state()

func _on_item_removed_from_backpack(index):
	update_required_resources_state()

func update_required_resources_state():
	if construction_name:
		var resources = Build.resource_requirements[construction_name]
		if Inventory.has_resources(resources): 
			modulate = Color(1, 1, 1, 1)
			has_resources = true
		else: 
			modulate = Color(1, 0.5, 0.5, 1)
			has_resources = false

