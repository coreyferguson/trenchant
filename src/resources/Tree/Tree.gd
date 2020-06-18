extends StaticBody2D

var health = 4
var health_capacity = 4
var wood
var sticks

func _init():
	wood = randi()%4+1
	sticks = randi()%8+1

func interact(interactor):
	$animation.play('shake')
	health = clamp(health-1, 0, health_capacity)
	if health == 0:
		queue_free()
		return [
			{ 'name': 'wood', 'quantity': wood },
			{ 'name': 'sticks', 'quantity': sticks }
		]
