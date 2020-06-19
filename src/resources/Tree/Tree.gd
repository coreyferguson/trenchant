extends StaticBody2D

var health = 4
var health_capacity = 4
var wood
var stick

func _ready():
	randomize()
	wood = randi()%4+1
	stick = randi()%8+1
	print(wood)

func interact(interactor):
	$animation.play('shake')
	health = clamp(health-1, 0, health_capacity)
	if health == 0:
		queue_free()
		return [
			{ 'name': 'wood', 'quantity': wood },
			{ 'name': 'stick', 'quantity': stick }
		]
