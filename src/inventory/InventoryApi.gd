extends Node

signal item_added_to_belt(index)
signal item_added_to_backpack(index)
signal item_removed_from_belt(index)
signal item_removed_from_backpack(index)

var belt = []
var backpack = []

func _init():
	belt.resize(4)

func collect(resources):
	if !resources: return
	for r in range(resources.size()):
		collect_single_resource(resources[r])

func collect_single_resource(resource):
	# add to existing belt item
	for i in range(belt.size()):
		if belt[i] && belt[i].name == resource.name:
			print('combining "' + str(resource.name) + '" to belt slot ' + str(i+1))
			belt[i].quantity += resource.quantity
			emit_signal("item_added_to_belt", i)
			return
	# add to existing backpack item
	for i in range(backpack.size()):
		if backpack[i] && backpack[i].name == resource.name:
			print('combining "' + str(resource.name) + '" to backpack slot ' + str(i+1))
			backpack[i].quantity += resource.quantity
			emit_signal("item_added_to_backpack", i)
			return
	# add new item to belt
	for i in range(belt.size()):
		if !belt[i]: 
			print('adding "' + str(resource.name) + '" to belt slot ' + str(i+1))
			belt[i] = resource
			emit_signal("item_added_to_belt", i)
			return
	# add new backpack item
	for i in range(backpack.size()):
		if !backpack[i]:
			print('adding "' + str(resource.name) + '" to backpack slot ' + str(i+1))
			backpack[i] = resource
			emit_signal("item_added_to_backpack", i)
			return

func has_resources(resources):
	for i in range(resources.size()):
		if !has_item_quantity(resources[i]): return false
	return true

func has_item_quantity(resource):
	for i in range(belt.size()):
		if belt[i] && belt[i].name == resource.name && belt[i].quantity >= resource.quantity:
			return true
	for i in range(backpack.size()):
		if backpack[i] && backpack[i].name == resource.name && backpack[i].quantity >= resource.quantity:
			return true
	return false

func remove(resources):
	for i in range(resources.size()):
		remove_single_resource(resources[i])

func remove_single_resource(resource):
	var belt_indexes_to_remove = []
	var backpack_indexes_to_remove = []
	for i in range(belt.size()):
		if belt[i] && belt[i].name == resource.name:
			belt[i].quantity -= resource.quantity
			if belt[i].quantity <= 0: belt_indexes_to_remove.push_back(i)
			emit_signal("item_removed_from_belt", i)
	for i in range(backpack.size()):
		if backpack[i] && backpack[i].name == resource.name:
			backpack[i].quantity -= resource.quantity
			if backpack[i].quantity <= 0: backpack_indexes_to_remove.push_back(i)
			emit_signal("item_removed_from_backpack", i)
	# remove spent items
	belt_indexes_to_remove.invert()
	for i in range(belt_indexes_to_remove.size()): belt.remove(i)
	backpack_indexes_to_remove.invert()
	for i in range(backpack_indexes_to_remove.size()): backpack.remove(i)
	
