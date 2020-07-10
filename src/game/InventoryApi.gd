extends Node

signal item_added_to_belt(index)
signal item_added_to_backpack(item_name)
signal item_removed_from_belt(index)
signal item_removed_from_backpack(item_name)

var belt = []
var backpack = {}

func _init():
	reset_state()

func collect(resources):
	if !resources || typeof(resources) != TYPE_ARRAY: return
	for r in range(resources.size()):
		collect_single_resource(resources[r])

func collect_single_resource(resource):
	# add to existing backpack item
	if backpack.has(resource.name):
		backpack[resource.name].quantity += resource.quantity
		emit_signal("item_added_to_backpack", resource.name)
		return
	# add new backpack item
	backpack[resource.name] = resource
	emit_signal("item_added_to_backpack", resource.name)

func has_resources(resources):
	for i in range(resources.size()):
		if !has_item_quantity(resources[i]): return false
	return true

func has_item_quantity(resource):
	if backpack.has(resource.name) && \
	   backpack[resource.name].quantity >= resource.quantity:
		return true
	return false

func remove(resources):
	for i in range(resources.size()):
		remove_single_resource(resources[i])

func remove_single_resource(resource):
	if backpack[resource.name]:
		backpack[resource.name].quantity -= resource.quantity
		if backpack[resource.name].quantity <= 0: 
			backpack.erase(resource.name)
			for i in range(belt.size()):
				if belt[i] && belt[i].name == resource.name:
					belt[i] = null
					emit_signal("item_removed_from_belt", i)
		emit_signal("item_removed_from_backpack", resource.name)

func reset_state():
	belt = [ { 'name': 'fist' } ]
	belt.resize(4)
	backpack = {
		'fist': { 'name': 'fist', 'quantity': 1 },
		'rock': { 'name': 'rock', 'quantity': 100 },
		'obsidian': { 'name': 'obsidian', 'quantity': 100 },
		'bow': { 'name': 'bow', 'quantity': 1 },
	}

func set_belt_slot(index, item):
	belt[index] = item
	emit_signal("item_added_to_belt", index)
