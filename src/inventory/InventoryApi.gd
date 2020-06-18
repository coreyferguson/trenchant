extends Node

signal item_added_to_belt(index)
signal item_added_to_backpack(index)

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
