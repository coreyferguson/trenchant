extends KinematicBody2D

signal play_enter_zone_animation_finished

export var health_capacity = 5
export var health = 5
export var speed = 200

var is_moving_up = false
var is_moving_right = false
var is_moving_down = false
var is_moving_left = false
var is_interacting = false

var bodies_in_interaction_range = []
var bodies_in_punch_range = []

func _process(delta):
	z_index = position.y

func _physics_process(delta):
	move()

func update_state():
	if Game.is_input_disabled: return
	if Input.is_action_just_pressed("move_up"):
		is_moving_up = true
		play_sprite_animation()
	if Input.is_action_just_released("move_up"):
		is_moving_up = false
		play_sprite_animation()
	if Input.is_action_just_pressed("move_right"):
		is_moving_right = true
		$bones/torso.scale.x = 1
		play_sprite_animation()
	if Input.is_action_just_released("move_right"):
		is_moving_right = false
		play_sprite_animation()
	if Input.is_action_just_pressed("move_down"):
		is_moving_down = true
		play_sprite_animation()
	if Input.is_action_just_released("move_down"):
		is_moving_down = false
		play_sprite_animation()
	if Input.is_action_just_pressed("move_left"):
		is_moving_left = true
		$bones/torso.scale.x = -1
		play_sprite_animation()
	if Input.is_action_just_released("move_left"):
		is_moving_left = false
		play_sprite_animation()
	if Input.is_action_just_pressed("interact"):
		is_interacting = true
		$interact_timer.start()
		play_sprite_animation()
	if Input.is_action_just_released("interact"):
		is_interacting = false
		$interact_timer.stop()
		play_sprite_animation()
	if Input.is_action_pressed("attack"):
		_attack_bodies_in_punch_range()

func _unhandled_input(event):
	update_state()

func move():
	var v = Vector2(0, 0)
	if is_moving_up: v += Vector2(0, -1)
	if is_moving_right: v += Vector2(1, 0)
	if is_moving_down: v += Vector2(0, 1)
	if is_moving_left: v += Vector2(-1, 0)
	v = v.normalized() * speed
	var collision = move_and_slide(v)

func is_moving():
	return is_moving_up || is_moving_right || is_moving_down || is_moving_left

func play_sprite_animation():
	if !is_moving() && !is_interacting: $animation.play('waiting')
	elif is_moving():
		if is_moving_left: $animation.play('running_left')
		else: $animation.play('running_right')
	elif is_interacting: $animation.play('interacting')

func _on_interact_timer_timeout():
	var body_indexes_to_remove = []
	for i in range(bodies_in_interaction_range.size()):
		var body_wr = bodies_in_interaction_range[i]
		if body_wr.get_ref():
			var body = body_wr.get_ref()
			if body.has_method('interact'):
				Inventory.collect(body.interact(self))
		else:
			body_indexes_to_remove.push_back(i)
	# remove bodies without references
	for i in range(body_indexes_to_remove.size()):
		bodies_in_interaction_range.remove(body_indexes_to_remove[i])

func _on_interact_range_body_entered(body):
	bodies_in_interaction_range.push_back(weakref(body))

func _on_interact_range_body_exited(body):
	var body_indexes_to_remove = []
	for i in range(bodies_in_interaction_range.size()):
		if bodies_in_interaction_range[i].get_ref():
			var other_body = bodies_in_interaction_range[i].get_ref()
			if other_body == body: body_indexes_to_remove.push_back(i)
		else:
			body_indexes_to_remove.push_back(i)
	# remove bodies without references
	body_indexes_to_remove.invert()
	for i in range(body_indexes_to_remove.size()):
		bodies_in_interaction_range.remove(body_indexes_to_remove[i])

func play_enter_zone_animation():
	$animation.play("enter_zone_animation")
	yield($animation, 'animation_finished')
	$animation.play('waiting')
	yield($animation, 'animation_finished')
	emit_signal("play_enter_zone_animation_finished")

func attack(damage):
	health = clamp(health - damage, 0, health_capacity)
	$health_bar.set_health(health, health_capacity)
	if health == 0:
		# TODO: end game
		queue_free()

func _on_punch_range_body_entered(body):
	if body.has_method('attack'):
		bodies_in_punch_range.push_back(weakref(body))

func _on_punch_range_body_exited(body):
	var indexes_to_delete = []
	for i in range(bodies_in_punch_range.size()):
		if !bodies_in_punch_range[i] || !bodies_in_punch_range[i].get_ref():
			indexes_to_delete.push_back(i)
		if bodies_in_punch_range[i].get_ref() == body:
			indexes_to_delete.push_back(i)
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		bodies_in_punch_range.remove(indexes_to_delete[i])

func _attack_bodies_in_punch_range():
	if $animation.is_playing() && $animation.current_animation == 'punch':
		return
	var indexes_to_delete = []
	for i in range(bodies_in_punch_range.size()):
		if !bodies_in_punch_range[i].get_ref():
			indexes_to_delete.push_back(i)
			continue
		bodies_in_punch_range[i].get_ref().attack(1)
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		bodies_in_punch_range.remove(indexes_to_delete[i])
	$animation.play("punch")
