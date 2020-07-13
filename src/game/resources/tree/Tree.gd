extends StaticBody2D

var health = 2
var health_capacity = 2

func _ready():
	randomize()

func interact(interactor):
	health -= 1
	if health == 0:
		queue_free()
		return [
			{ 'name': 'wood', 'quantity': 2 }
		]
