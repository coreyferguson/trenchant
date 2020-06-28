extends Node

signal item_added_to_belt(index)
signal item_added_to_backpack(item_name)
signal item_removed_from_belt(index)
signal item_removed_from_backpack(item_name)

var belt = [{ 'name': 'fist' }]
var backpack = {
	'fist': { 'name': 'fist', 'quantity': 1 }
}

func _init():
	belt.resize(4)

func collect(resources):
	if !resources || typeof(resources) != TYPE_ARRAY: return
	for r in range(resources.size()):
		collect_single_resource(resources[r])

func collect_single_resource(resource):
	# add to existing backpack item
	if backpack.has(resource.name):
		print('combining "' + str(resource.name) + '" to backpack')
		backpack[resource.name].quantity += resource.quantity
		emit_signal("item_added_to_backpack", resource.name)
		return
	# add new backpack item
	print('adding "' + str(resource.name) + '" to backpack')
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
		if backpack[resource.name].quantity <= 0: backpack.remove(resource.name)
		emit_signal("item_removed_from_backpack", resource.name)
