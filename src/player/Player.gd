extends KinematicBody2D

export var speed = 200

var is_moving_up = false
var is_moving_right = false
var is_moving_down = false
var is_moving_left = false
var is_interacting = false

var bodies_in_interaction_range = []

func _process(delta):
	move(delta)

func update_state():
	if Input.is_action_just_pressed("move_up"):
		is_moving_up = true
		play_sprite_animation()
	if Input.is_action_just_released("move_up"):
		is_moving_up = false
		play_sprite_animation()
	if Input.is_action_just_pressed("move_right"):
		is_moving_right = true
		$sprite.flip_h = false
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
		$sprite.flip_h = true
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

func _unhandled_input(event):
	update_state()

func move(delta):
	var v = Vector2(0, 0)
	if is_moving_up: v += Vector2(0, -1)
	if is_moving_right: v += Vector2(1, 0)
	if is_moving_down: v += Vector2(0, 1)
	if is_moving_left: v += Vector2(-1, 0)
	v = v.normalized() * speed * delta
	move_and_collide(v)

func is_moving():
	return is_moving_up || is_moving_right || is_moving_down || is_moving_left

func play_sprite_animation():
	if !is_moving() && !is_interacting: $sprite.play('waiting')
	elif is_moving(): $sprite.play('running')
	elif is_interacting: $sprite.play('interacting')

func _on_interact_timer_timeout():
	var body_indexes_to_remove = []
	for i in range(bodies_in_interaction_range.size()):
		var body_wr = bodies_in_interaction_range[i]
		if body_wr.get_ref():
			var body = body_wr.get_ref()
			if body.has_method('interact'):
				var resources = body.interact(self)
				Inventory.collect(resources)
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
	$sprite.play('running')
	$animation.connect("animation_finished", self, "_on_enter_zone_animation_finished")
	$animation.play("enter_zone_animation")

func _on_enter_zone_animation_finished(name):
	$sprite.play('waiting')
