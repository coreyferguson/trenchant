extends StaticBody2D

var quantity

func _ready():
	randomize()
	quantity = randi()%2+1

func interact(interactor):
	queue_free()
	return [ { 'name': 'rock', 'quantity': quantity } ]
