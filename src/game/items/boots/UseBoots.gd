extends Node2D

var required_resources = [{ 'name': 'boots', 'quantity': 1 }]

func _ready():
	if Inventory.has_resources(required_resources):
		Inventory.remove(required_resources)
		Buffs.add_buff('movement_speed', 'item', 'boots')
	else:
		queue_free()

func _on_timer_timeout():
	Buffs.remove_buff('movement_speed', 'item', 'boots')
	queue_free()
