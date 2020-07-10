extends Area2D

var has_physics_completed_once = false

func _physics_process(delta):
	# overlapping bodies won't be available until after first phsyics round
	if !has_physics_completed_once:
		has_physics_completed_once = true
		return
	# get overlapping bodies and attack
	var bodies = get_overlapping_bodies()
	for i in range(bodies.size()):
		if bodies[i].has_method('attack'):
			bodies[i].attack(1)
	# clean yourself up, you're dirty
	queue_free()
