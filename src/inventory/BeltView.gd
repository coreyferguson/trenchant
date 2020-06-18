extends HBoxContainer

var BeltSlot = preload("res://src/inventory/BeltSlot.tscn")

func _ready():
	Inventory.connect("item_added_to_belt", self, '_on_inventory_item_added_to_belt')

func _on_inventory_item_added_to_belt(index):
	var resource = Inventory.belt[index]
	var belt_slot = BeltSlot.instance()
	belt_slot.name = resource.name
	belt_slot.icon = Items.get(resource.name).icon
	belt_slot.quantity = resource.quantity
	add_child(belt_slot)
