extends KinematicBody2D

signal died

export(int) var speed = 200 setget set_speed
var speed_squared = speed*speed
export var damage = 20
export var health = 25
export var health_capacity = 25

var detected_bodies = []
var attack_bodies = []
var target
var home_position

func _ready():
	$sprite.play('waiting')
	home_position = global_position

func _process(delta):
	attack_bodies_in_range()

func _physics_process(delta):
	var target_position
	if target && target.get_ref():
		target_position = target.get_ref().global_position
	elif global_position != home_position:
		target_position = home_position
	if target_position:
		var v = target_position - global_position
		if v.x >= 0: $sprite.flip_h = false
		else: $sprite.flip_h = true
		if v.length_squared() <= pow(speed*delta, 2): 
			move_and_collide(v)
			choose_target()
		else: move_and_slide(v.normalized() * speed)

func set_speed(new_speed):
	speed = new_speed
	speed_squared = speed * speed
	
func choose_target():
	if detected_bodies.size() > 0: 
		target = detected_bodies[0]
		$sprite.play('running')
	elif global_position == home_position:
		target = null
		$sprite.play('waiting')
	else:
		$sprite.play('running')

func _on_detection_area_body_entered(body):
	if body.has_method('attack'): 
		detected_bodies.push_back(weakref(body))
		choose_target()

func _on_detection_area_body_exited(body):
	if body.has_method('attack'):
		for i in range(detected_bodies.size()):
			if detected_bodies[i].get_ref() == body:
				detected_bodies.remove(i)
				break
		choose_target()

func _on_attack_range_body_entered(body):
	if body.has_method('attack'): attack_bodies.push_back(weakref(body))

func _on_attack_range_body_exited(body):
	var indexes_to_delete = []
	if body.has_method('attack'):
		for i in range(attack_bodies.size()):
			if !attack_bodies[i].get_ref() && attack_bodies[i].get_ref() == body:
				indexes_to_delete = i
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		attack_bodies.remove(indexes_to_delete[i])

func attack_bodies_in_range():
	if $attack_delay.is_stopped() && attack_bodies.size() > 0:
		for i in range(attack_bodies.size()):
			var body = attack_bodies[i].get_ref()
			if body && body.has_method('attack'):
				body.attack(damage)
				$attack_delay.start()
				$sprite.play('attacking')
		if $sprite.is_playing() && $sprite.animation == 'attacking':
			yield($sprite, 'animation_finished')
			choose_target()

func attack(damage):
	health = clamp(health-damage, 0, health_capacity)
	if health == 0: queue_free()
