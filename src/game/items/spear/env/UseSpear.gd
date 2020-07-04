extends Node2D

func _ready():
	rotation = (get_global_mouse_position() - global_position).angle()

func use():
	var bodies = $attack_area.get_overlapping_bodies()
	for i in range(bodies.size()):
		if bodies[i].has_method('attack'):
			bodies[i].attack(5)
	queue_free()
