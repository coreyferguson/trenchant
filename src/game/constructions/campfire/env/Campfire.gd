extends StaticBody2D

func _ready():
	Buffs.add_buff('replenish_health_leaving_home', 'construction', 'campfire')
	Zone.connect('leaving_zone', self, '_on_zone_leaving')

func get_persisted_properties():
	return {
		'scene': Construction.constructions['campfire'].scene,
		'state': {
			'global_position': global_position
		}
	}

func restore_persisted_state(state):
	global_position = state.global_position

func _on_zone_leaving():
	Player.add_health(5)
	Buffs.remove_buff('replenish_health_leaving_home', 'construction', 'campfire')
