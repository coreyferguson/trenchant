extends Node2D

var has_physics_completed_once = false
var required_resources = [ { 'name': 'spear', 'quantity': 1 } ]

func _physics_process(delta):
	if !has_physics_completed_once:
		has_physics_completed_once = true
		return
	if Inventory.has_resources(required_resources):
		Inventory.remove(required_resources)
		rotation = (get_global_mouse_position() - global_position).angle()
		var bodies = $attack_area.get_overlapping_bodies()
		for i in range(bodies.size()):
			if bodies[i].has_method('attack'):
				bodies[i].attack(5)
	queue_free()
