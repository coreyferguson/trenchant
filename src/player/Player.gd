extends KinematicBody2D

signal play_enter_zone_animation_finished

export var speed = 200

var is_moving_up = false
var is_moving_right = false
var is_moving_down = false
var is_moving_left = false

var is_interacting = false

var is_using_belt_1 = false
var is_using_belt_2 = false
var is_using_belt_3 = false
var is_using_belt_4 = false
var is_use_animation_playing = false

func _ready():
	$health_bar.set_health(Player.health, Player.health_capacity)

func _process(delta):
	z_index = position.y
	_interact()
	_use_belt_items()
	_update_animation()

func _physics_process(delta):
	_move()

func _unhandled_input(event):
	update_state()

func attack(damage):
	Player.health = clamp(Player.health - damage, 0, Player.health_capacity)
	$health_bar.set_health(Player.health, Player.health_capacity)
	if Player.health == 0:
		# TODO: end game
		queue_free()

func play_enter_zone_animation():
	$animation.play("enter_zone_animation")
	yield($animation, 'animation_finished')
	$animation.play('waiting')
	yield($animation, 'animation_finished')
	emit_signal("play_enter_zone_animation_finished")

func update_state():
	if Input.is_action_just_pressed("move_up"): is_moving_up = true
	if Input.is_action_just_released("move_up"): is_moving_up = false
	if Input.is_action_just_pressed("move_right"): is_moving_right = true
	if Input.is_action_just_released("move_right"): is_moving_right = false
	if Input.is_action_just_pressed("move_down"): is_moving_down = true
	if Input.is_action_just_released("move_down"): is_moving_down = false
	if Input.is_action_just_pressed("move_left"): is_moving_left = true
	if Input.is_action_just_released("move_left"): is_moving_left = false
	if Input.is_action_just_pressed("interact"): is_interacting = true
	if Input.is_action_just_released("interact"): is_interacting = false
	if Input.is_action_just_pressed("use_1"): is_using_belt_1 = true
	if Input.is_action_just_released("use_1"): is_using_belt_1 = false
	if Input.is_action_just_pressed("use_2"): is_using_belt_2 = true
	if Input.is_action_just_released("use_2"): is_using_belt_1 = false
	if Input.is_action_just_pressed("use_3"): is_using_belt_3 = true
	if Input.is_action_just_released("use_3"): is_using_belt_1 = false
	if Input.is_action_just_pressed("use_4"): is_using_belt_4 = true
	if Input.is_action_just_released("use_4"): is_using_belt_1 = false

func _interact():
	if _is_moving() || is_use_animation_playing: return
	if is_interacting: $animation.play("interacting")
	if $interact_timer.is_stopped():
		$interact_timer.start()
		var bodies = $interact_range.get_overlapping_bodies()
		for i in range(bodies.size()):
			if bodies[i].has_method('interact'):
				Inventory.collect(bodies[i].interact(self))

func _is_moving():
	return is_moving_up || is_moving_right || is_moving_down || is_moving_left

func _is_using():
	return is_using_belt_1 || is_using_belt_2 || is_using_belt_3 || is_using_belt_4

func _move():
	if Game.is_input_disabled: return
	var v = Vector2(0, 0)
	if is_moving_up: v += Vector2(0, -1)
	if is_moving_right:
		v += Vector2(1, 0)
		$bones/torso.scale.x = 1
	if is_moving_down: v += Vector2(0, 1)
	if is_moving_left:
		v += Vector2(-1, 0)
		$bones/torso.scale.x = -1
	v = v.normalized() * speed
	var collision = move_and_slide(v)

func _on_interact_timer_timeout():
	var bodies = $interact_range.get_overlapping_bodies()
	for i in range(bodies.size()):
		var body = bodies[i]
		if body.has_method('interact'): Inventory.collect(body.interact(self))

func _update_animation():
	if Game.is_input_disabled: return
	if is_use_animation_playing: return
	if is_moving_left: return $animation.play("running_left")
	if _is_moving(): return $animation.play("running_right")
	if is_interacting: return $animation.play("interacting")
	$animation.play("waiting")

func _use_belt_item(index):
	if !$use_again_delay_timer.is_stopped(): return
	var item = Inventory.belt[index]
	if !item: return
	var md = Items.items[item.name]
	$use_again_delay_timer.wait_time = md.useable.use_again_delay_in_seconds
	$use_again_delay_timer.start()
	_use_belt_item_play_animation(item.name)
	_use_belt_item_instantiate(item.name)

func _use_belt_items():
	if is_using_belt_1: _use_belt_item(0)
	if is_using_belt_2: _use_belt_item(1)
	if is_using_belt_3: _use_belt_item(2)
	if is_using_belt_4: _use_belt_item(3)
	
func _use_belt_item_instantiate(item_name):
	var md = Items.items[item_name]
	$instance_delay_timer.wait_time = md.useable.scene_instance_delay_in_seconds
	$instance_delay_timer.start()
	var instance = md.useable.scene.instance()
	instance.global_position = global_position
	Env.add(instance)
	yield($instance_delay_timer, "timeout")
	instance.use()

func _use_belt_item_play_animation(item_name):
	Game.is_input_disabled = true
	is_use_animation_playing = true
	if $animation.has_animation('use_' + item_name):
		$animation.play('use_' + item_name)
	yield($animation, "animation_finished")
	is_use_animation_playing = false
	Game.is_input_disabled = false
