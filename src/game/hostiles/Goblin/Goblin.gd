extends KinematicBody2D

signal killed
signal arrived_at_target_position

onready var Arrow = preload("./Arrow.tscn")

export var speed = 100
export var arrow_speed = 500
export var health = 5 setget _set_health
export var health_capacity = 5

var running_target_position

func _physics_process(delta):
	z_index = global_position.y
	if running_target_position:
		var d = running_target_position - global_position
		var v = d.normalized() * speed
		if d.length_squared() < v.length_squared():
			move_and_slide(d)
			emit_signal("arrived_at_target_position")
			stop()
		else:
			move_and_slide(v)
		if v.x >= 0: look_right()
		elif v.x < 0: look_left()

func attack(damage):
	health = clamp(health - damage, 0, health_capacity)
	$health_bar.set_health(health, health_capacity)
	if health == 0: 
		queue_free()
		emit_signal('killed')

func look_left():
	$bones/body.scale.x = -1

func look_right():
	$bones/body.scale.x = 1
		
func move_to(position):
	running_target_position = position
	$animation.play("running")

func shoot_at(target):
	if target:
		var direction = target - global_position
		if direction.x >= 0: $bones/body.scale.x = 1
		elif direction.x < 0: $bones/body.scale.x = -1
		$animation.play("attacking")
		$animation_attack_delay.start()
		yield($animation_attack_delay, "timeout")
		var arrow = Arrow.instance()
		Env.add(arrow)
		arrow.global_position = global_position - Vector2(0, 75)
		arrow.velocity = (target - arrow.global_position).normalized() * arrow_speed
		arrow.rotation = arrow.velocity.angle()

func shoot_left():
	shoot_at(global_position - Vector2(1000, 75))

func stop():
	running_target_position = null
	$animation.play("resting")

func _set_health(new_health):
	health = new_health
	$health_bar.set_health(health, health_capacity)
