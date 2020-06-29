extends Area2D
	
func use():
	var bodies = get_overlapping_bodies()
	for i in range(bodies.size()):
		if bodies[i].has_method('attack'):
			bodies[i].attack(1)
	queue_free()
