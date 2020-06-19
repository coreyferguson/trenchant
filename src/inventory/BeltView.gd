extends HBoxContainer

var BeltSlot = preload("res://src/inventory/BeltSlot.tscn")

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
	for i in range(children.size()): children[i].queue_free()
	for i in range(Inventory.belt.size()):
		var resource = Inventory.belt[i]
		if !resource: return
		var belt_slot = BeltSlot.instance()
		belt_slot.name = resource.name
		belt_slot.icon = Items.get(resource.name).icon
		belt_slot.quantity = resource.quantity
		add_child(belt_slot)
