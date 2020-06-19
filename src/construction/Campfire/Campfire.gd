extends StaticBody2D

func get_persisted_properties():
	return {
		'scene': Construction.constructions['campfire'].scene,
		'state': {
			'global_position': global_position
		}
	}

func restore_persisted_state(state):
	global_position = state.global_position
