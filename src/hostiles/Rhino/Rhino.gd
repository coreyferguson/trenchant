extends KinematicBody2D

signal killed
signal arrived_at_target_position

export(int) var health = 12
export(int) var health_capacity = 12

enum States { RESTING, WALKING, ANNOYED, CHARGING, ATTACKING }
var current_state

export(int) var speed_walking = 100
export(int) var speed_charging = 400
export(int) var charge_range = 750

var target_position

onready var charge_attack_area = $charge_attack_area

func _ready():
	_rest()

func _physics_process(delta):
	z_index = global_position.y
	var speed
	if current_state == States.WALKING: speed = speed_walking
	if current_state == States.CHARGING: speed = speed_charging
	if current_state == States.WALKING || current_state == States.CHARGING:
		var d = target_position - global_position
		var v = d.normalized() * speed
		var v_delta = v * delta
		if d.length_squared() > v_delta.length_squared(): move_and_slide(v)
		else: move_and_slide(d)
		if target_position.distance_to(global_position) < 20:
			emit_signal('arrived_at_target_position')
			print('arrived at target position')

func attack(damage):
	health = clamp(health - damage, 0, health_capacity)
	$health_bar.set_health(health, health_capacity)
	if health == 0: 
		queue_free()
		emit_signal('killed')
	# if damaged from distant ranged attack
	if current_state == States.RESTING || \
	   current_state == States.WALKING || \
	   current_state == States.ANNOYED:
		var bodies = $charge_area.get_overlapping_bodies()
		if bodies.size() == 0: 
			_cancel_current_state()
			_charge(Env.get_player())

func _annoy():
	current_state = States.ANNOYED
	$animation.play("annoyed")
	$annoy_timer.start()
	yield($annoy_timer, 'timeout')
	_update_state()

func _attack(body):
	current_state = States.ATTACKING
	$animation.play('attack')
	yield($animation, 'animation_finished')
	_update_state()

func _cancel_current_state():
	$animation.stop()
	$annoy_timer.stop()
	$rest_timer.stop()
	$walk_timer.stop()
	current_state = States.RESTING
	target_position = null

func _charge(body):
	print('charge start')
	current_state = States.CHARGING
	$charge_attack_area/particles.emitting = true
	$animation.play('charging', -1, 4)
	# look at body
	var v = body.global_position - global_position
	if v.x > 0: $bones/body.scale.x = 1
	elif v.x < 0: $bones/body.scale.x = -1
	# rotate charge_attack_area towards body
	v = body.global_position - global_position
	charge_attack_area.rotation = v.angle()
	# charge towards body for exactly charge_range distance
	v = v.normalized() * charge_range
	target_position = global_position + v
	yield(self, 'arrived_at_target_position')
	$charge_attack_area/particles.emitting = false
	print('charge end')
	_rest()

func _rest():
	print('rest start')
	current_state = States.RESTING
	$animation.play("resting")
	$rest_timer.start()
	yield($rest_timer, 'timeout')
	print('rest end')
	_update_state()

func _update_state():
	var attack_area_bodies = $attack_area.get_overlapping_bodies()
	var charge_area_bodies = $charge_area.get_overlapping_bodies()
	var annoyed_area_bodies = $annoyed_area.get_overlapping_bodies()
	if attack_area_bodies.size() > 0: _attack(attack_area_bodies[0])
	elif charge_area_bodies.size() > 0: _charge(charge_area_bodies[0])
	elif annoyed_area_bodies.size() > 0: _annoy()
	elif current_state == States.ANNOYED: _rest()
	elif current_state == States.ATTACKING: _rest()
	elif current_state == States.RESTING: _walk()
	elif current_state == States.WALKING: _rest()

func _walk():
	print('walk start')
	current_state = States.WALKING
	$animation.play('running', -1, 1)
	target_position = Game.get_random_spawn_position()
	if (target_position - global_position).x > 0: $bones/body.scale.x = 1
	else: $bones/body.scale.x = -1
	$walk_timer.start()
	yield($walk_timer, 'timeout')
	print('walk end')
	_update_state()

func _on_charge_attack_area_body_entered(body):
	if current_state == States.CHARGING:
		if body.has_method('attack'):
			body.attack(2)
