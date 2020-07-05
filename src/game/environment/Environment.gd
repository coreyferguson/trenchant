extends Node2D

var ExploreView = preload("../zones/explore/ExploreView.tscn")
var home_background = preload("../zones/forest/background.png")

func _ready():
	if Zone.is_home():
		Env.restore_persisted_nodes()
		$background.texture = home_background
	else:
		$background.texture = Zone.zones[Zone.current_zone].background
	Level.level += 1
	Env.add(ExploreView.instance())
	Zone.spawn()
	Hostile.spawn()
	_apply_buff_sheep_dog()
	Env.fade_in()
	yield(Env, 'fade_finished')
	Game.is_input_disabled = true
	$player.play_enter_zone_animation()
	yield($player, "play_enter_zone_animation_finished")
	Game.is_input_disabled = false

func _apply_buff_sheep_dog():
	if Buffs.has_global_buff('sheep_dog'):
		var SheepDog = \
			Buffs.get_global_buff('sheep_dog', 'construction', 'sheep_farm')\
			.context.scene
		var sheep_dog = SheepDog.instance()
		sheep_dog.global_position = Game.get_random_circumference_position(\
			Env.get_player().global_position, 200)
		Env.add(sheep_dog)
