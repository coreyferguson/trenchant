extends KinematicBody2D

var velocity

func _physics_process(delta):
	if velocity:
		var collision = move_and_collide(velocity * delta)
		if collision:
			if collision.collider.has_method('attack'):
				collision.collider.attack(1)
			queue_free()
