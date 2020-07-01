extends StaticBody2D

var quantity
var health = 2

func _ready():
	randomize()
	quantity = randi()%2+1

func interact(interactor):
	health -= 1
	if health == 0:
		queue_free()
		return [ { 'name': 'obsidian', 'quantity': quantity } ]
