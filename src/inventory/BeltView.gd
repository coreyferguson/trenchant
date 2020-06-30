extends VBoxContainer

func _ready():
	Inventory.connect("item_added_to_belt", self, '_on_inventory_item_added_to_belt')
	Inventory.connect("item_removed_from_belt", self, '_on_inventory_item_removed_from_belt')
	redraw_belt_slots()

func _on_inventory_item_added_to_belt(index):
	redraw_belt_slots()

func _on_inventory_item_removed_from_belt(index):
	redraw_belt_slots()

func redraw_belt_slots():
	var children = $bg/MarginContainer/vbox/slots.get_children()
	for i in range(children.size()):
		var belt_slot = children[i]
		if Inventory.belt[i] == null:
			belt_slot.name = ""
			belt_slot.icon = null
		else:
			var belt_item_name = Inventory.belt[i].name
			belt_slot.name = belt_item_name
			belt_slot.icon = Items.items[belt_item_name].icon
