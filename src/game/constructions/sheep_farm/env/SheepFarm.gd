extends KinematicBody2D

var SheepDog = preload("./sheep_dog/SheepDog.tscn")

# cached state between calls:
# 1. restore_persisted_state(state)
# 2. _ready()
# 3. get_persisted_properties()
var dog
var dog_health

func _ready():
	dog = SheepDog.instance()
	dog.global_position = Game\
		.get_random_circumference_position(global_position, 200)
	dog.home_position = dog.global_position
	if dog_health: dog.health = dog_health
	Env.add(dog)

func attack(damage):
	queue_free()

func get_persisted_properties():
	return {
		'scene': Construction.constructions['sheep_farm'].scene,
		'state': {
			'global_position': global_position,
			'dog_health': dog.health
		}
	}

func restore_persisted_state(state):
	global_position = state.global_position
	dog_health = state.dog_health
