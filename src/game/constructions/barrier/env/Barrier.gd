extends StaticBody2D

export(int) var health_capacity = 2
export(int) var health = 2

func _ready():
	$health_bar.set_health(health, health_capacity)
	z_index = $bottom.global_position.y

func get_persisted_properties():
	return {
		'scene': Construction.constructions['barrier'].scene,
		'state': {
			'global_position': global_position,
			'health': health
		}
	}

func restore_persisted_state(state):
	global_position = state.global_position
	health = state.health
	print('health:' + str(health))
	$health_bar.set_health(health, health_capacity)

func attack(damage):
	health = clamp(health-damage, 0, health_capacity)
	$health_bar.set_health(health, health_capacity)
	if health == 0: queue_free()
