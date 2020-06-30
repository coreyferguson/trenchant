extends KinematicBody2D

signal killed

onready var Arrow = preload("./Arrow.tscn")

export var speed = 100
export var arrow_speed = 500
export var health = 5
export var health_capacity = 5

enum STATES { SHOOTING, RUNNING }
var current_state = STATES.RUNNING

var running_target_position
var shooting_targets = []

func _ready():
	_run()

func _physics_process(delta):
	if current_state == STATES.RUNNING:
		var v = running_target_position - global_position
		if v.length_squared() > pow(speed, 2): v = v.normalized() * speed
		if v.x >= 0: $bones/body.scale.x = 1
		elif v.x < 0: $bones/body.scale.x = -1
		move_and_slide(v)
	z_index = global_position.y

func _on_state_change_timer_timeout():
	if current_state == STATES.RUNNING:
		_shoot()
	elif current_state == STATES.SHOOTING:
		_run()
		
func _run():
	current_state = STATES.RUNNING
	running_target_position = Game.get_random_spawn_position()
	$animation.play("running")

func _shoot():
	current_state = STATES.SHOOTING
	var closest_target = _find_and_prune_closest_body(shooting_targets, self.global_position)
	if closest_target:
		var direction = closest_target.global_position - global_position
		if direction.x >= 0: $bones/body.scale.x = 1
		elif direction.x < 0: $bones/body.scale.x = -1
		$animation.play("attacking")
		$animation_attack_delay.start()
		yield($animation_attack_delay, "timeout")
		var arrow = Arrow.instance()
		Env.add(arrow)
		arrow.global_position = global_position - Vector2(0, 75)
		arrow.velocity = (closest_target.global_position - arrow.global_position).normalized() * arrow_speed
		arrow.rotation = arrow.velocity.angle()

func _on_shooting_detection_area_body_entered(body):
	if body.has_method('attack'):
		shooting_targets.push_back(weakref(body))

func _on_shooting_detection_area_body_exited(body):
	var indexes_to_delete = []
	for i in range(shooting_targets.size()):
		if !shooting_targets[i].get_ref(): indexes_to_delete.push_back(i)
		if shooting_targets[i].get_ref() == body: indexes_to_delete.push_back(i)
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		shooting_targets.remove(indexes_to_delete[i])

func _find_and_prune_closest_body(bodies, reference_position):
	# initialize closest_body as first body (that still exists)
	var closest_body
	while (!closest_body):
		if bodies.size() == 0: return
		if !bodies[0].get_ref(): 
			bodies.remove(0)
			continue
		closest_body = bodies[0].get_ref()
	var closest_distance = (closest_body.global_position - reference_position).length_squared()
	# loop through bodies and find closest_body
	for i in range(bodies.size()):
		var distance = (bodies[i].get_ref().global_position - reference_position).length_squared()
		if distance < closest_distance:
			closest_distance = distance
			closest_body = bodies[i].get_ref()
	return closest_body

func attack(damage):
	health = clamp(health - damage, 0, health_capacity)
	$health_bar.set_health(health, health_capacity)
	if health == 0: queue_free()
