extends StaticBody2D

var health = 2

func _ready():
	randomize()

func interact(interactor):
	health -= 1
	if health == 0:
		queue_free()
		return [ { 'name': 'obsidian', 'quantity': 2 } ]
