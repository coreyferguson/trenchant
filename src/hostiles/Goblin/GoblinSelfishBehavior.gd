extends Node2D

enum STATES { SHOOTING, RUNNING }
var current_state = STATES.RUNNING

var shooting_targets = []

var health setget set_health

func set_health(health): $goblin.health = health

func _ready():
	_run()

func _on_state_change_timer_timeout():
	if current_state == STATES.RUNNING:
		_shoot()
	elif current_state == STATES.SHOOTING:
		_run()
		
func _run():
	if !$goblin: return
	current_state = STATES.RUNNING
	$goblin.move_to(Game.get_random_spawn_position())

func _shoot():
	var goblin = $goblin
	if !goblin: return
	current_state = STATES.SHOOTING
	var closest_target = _find_and_prune_closest_body(shooting_targets, self.global_position)
	goblin.stop()
	if closest_target: goblin.shoot_at(closest_target.global_position)

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
	if !$goblin: return
	$goblin.attack(damage)

func _on_goblin_killed():
	queue_free()
