extends KinematicBody2D

var SheepDogScene = preload("./SheepDog/SheepDog.tscn")

var sheep_dog_capacity = 2
var sheep_dogs = []

func spawn_sheep_dog(global_position):
	var sheep_dog = SheepDogScene.instance()
	sheep_dog.global_position = global_position
	sheep_dog.connect("died", self, '_on_sheep_dog_died')
	sheep_dogs.push_back(weakref(sheep_dog))
	Env.add(sheep_dog)
	return sheep_dog
	

func get_persisted_properties():
	var sheep_dogs_persisted_properties = []
	for i in range(sheep_dogs.size()):
		var sheep_dog = sheep_dogs[i].get_ref()
		if !sheep_dog: continue
		sheep_dogs_persisted_properties.push_back({ 'global_position': sheep_dog.global_position })
	return {
		'scene': Construction.constructions['sheep_farm'].scene,
		'state': {
			'global_position': global_position,
			'sheep_dogs': sheep_dogs_persisted_properties
		}
	}

func restore_persisted_state(state):
	print('state.sheep_dogs: ' + str(state.sheep_dogs))
	global_position = state.global_position
	for i in range(state.sheep_dogs.size()):
		spawn_sheep_dog(state.sheep_dogs[i].global_position)
	if sheep_dogs.size() < sheep_dog_capacity:
		randomize()
		var i = randi()%2
		var position = Game.get_random_circumference_position(global_position, 150)
		if i == 0: spawn_sheep_dog(position)

func _on_sheep_dog_died(sheep_dog):
	for i in range(sheep_dogs.size()):
		if !sheep_dogs[i].get_ref(): sheep_dogs.remove(i)
		if sheep_dogs[i].get_ref() == sheep_dog:
			sheep_dogs.remove(i)
			break
