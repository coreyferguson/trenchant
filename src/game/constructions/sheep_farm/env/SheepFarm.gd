extends KinematicBody2D

var SheepDog = preload("./sheep_dog/SheepDog.tscn")

func _ready():
	if Zone.is_home():
		Buffs.add_global_buff(\
			'sheep_dog', \
			'construction', \
			'sheep_farm', \
			{ 'scene': SheepDog })

func get_persisted_properties():
	return {
		'scene': Construction.constructions['sheep_farm'].scene,
		'state': {
			'global_position': global_position,
		}
	}

func restore_persisted_state(state):
	global_position = state.global_position
