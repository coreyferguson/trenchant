extends KinematicBody2D

export(int) var speed = 200
export(int) var damage = 1
export(int) var health = 5 setget _set_health
export(int) var health_capacity = 5

var proximity_to_player = 200
var proximity_to_player_squared = pow(proximity_to_player, 2)

enum States { FOLLOWING, CHASING, ATTACKING }
var current_state = States.FOLLOWING

var chasing_target

func _ready():
	_update_state()

func _physics_process(delta):
	if current_state == States.CHASING:
		if !chasing_target || !chasing_target.get_ref():
			_update_state()
			return
		var v = chasing_target.get_ref().global_position - global_position
		v = v.normalized() * speed
		if v.x > 0: _look_right()
		if v.x < 0: _look_left()
		if v.length_squared() > 0: $animation.play('running')
		move_and_slide(v)
	if current_state == States.FOLLOWING:
		var target_destination = global_position - Env.get_player().global_position
		target_destination = target_destination.normalized() * proximity_to_player
		target_destination = Env.get_player().global_position + target_destination
		var d = target_destination - global_position
		var v = d.normalized() * speed
		if v.x > 0: _look_right()
		if v.x < 0: _look_left()
		var v_delta = v * delta
		if d.length_squared() > v_delta.length_squared(): 
			$animation.play('running')
			move_and_slide(v)
		else: 
			if d.length_squared() < 5: $animation.play('waiting')
			move_and_slide(d)

func attack(damage):
	_set_health(health-damage)
	if health == 0: queue_free()

func _attack(body):
	current_state = States.ATTACKING
	var v = body.global_position - global_position
	if v.x < 0: $animation.play("attack_left")
	else: $animation.play("attack_right")
	if body.has_method('attack'): body.attack(damage)
	yield($animation, "animation_finished")
	_update_state()

func _chase(body):
	current_state = States.CHASING
	chasing_target = weakref(body)

func _follow():
	current_state = States.FOLLOWING

func _is_in_range_of_player():
	var v = Env.get_player().global_position - global_position
	return v.length_squared() <= proximity_to_player_squared

func _look_left():
	$bones/body.scale.x = -1

func _look_right():
	$bones/body.scale.x = 1

func _set_health(new_health):
	health = clamp(new_health, 0, health_capacity)
	$health_bar.set_health(health, health_capacity)

func _update_state():
	var attack_area_bodies = $attack_area.get_overlapping_bodies()
	if attack_area_bodies.size() > 0:
		_attack(attack_area_bodies[0])
		return
	var detection_area_bodies = $detection_area.get_overlapping_bodies()
	if detection_area_bodies.size() > 0:
		_chase(detection_area_bodies[0])
		return
	_follow()

func _on_detection_area_body_entered(body):
	if current_state == States.FOLLOWING: _chase(body)
