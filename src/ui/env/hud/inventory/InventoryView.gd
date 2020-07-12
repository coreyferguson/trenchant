extends MarginContainer

func _ready():
	Inventory.connect("item_added_to_backpack", self, '_on_item_added_to_backpack')
	Inventory.connect("item_removed_from_backpack", self, '_on_item_removed_from_backpack')
	_redraw_backpack_slots()

func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		visible = false

func toggle_visibility():
	visible = !visible

func _on_item_added_to_backpack(item_name):
	_redraw_backpack_slots()

func _on_item_removed_from_backpack(item_name):
	_redraw_backpack_slots()

func _redraw_backpack_slots():
	# clear existing slots
	var slots = $background/margin/vbox/slots.get_children()
	for i in range(slots.size()):
		slots[i].icon = null
		slots[i].label = ""
		slots[i].quantity = null
	# fill in current items
	var item_names = Inventory.backpack.keys()
	item_names.sort()
	for i in range(item_names.size()):
		var slot = $background/margin/vbox/slots.get_node('inventory_slot' + str(i))
		slot.icon = Items.get(item_names[i]).icon
		slot.label = item_names[i]
		slot.quantity = Inventory.backpack[item_names[i]].quantity
