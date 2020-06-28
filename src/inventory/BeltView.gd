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
	var children = get_children()
	for i in range(children.size()):
		var belt_slot = get_node('slots/belt_slot' + str(i))
		if Inventory.belt[i] == null:
			belt_slot.name = ""
			belt_slot.icon = null
		else:
			var belt_item_name = Inventory.belt[i].name
			belt_slot.name = belt_item_name
			belt_slot.icon = Items.items[belt_item_name].icon
		
#	var children = get_children()
#	for i in range(children.size()): children[i].queue_free()
#	for i in range(Inventory.belt.size()):
#		var resource = Inventory.belt[i]
#		if !resource: continue
#		var belt_slot = BeltSlot.instance()
#		belt_slot.name = resource.name
#		belt_slot.icon = Items.get(resource.name).icon
#		belt_slot.quantity = resource.quantity
#		add_child(belt_slot)
