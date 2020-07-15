extends StaticBody2D

export(int) var health = 2
var resources = [ { 'name': 'rock', 'quantity': 2 } ]

func _ready():
	randomize()

func interact(interactor):
	health -= 1
	if health == 0:
		queue_free()
		return resources
