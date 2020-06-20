extends KinematicBody2D

export var health = 50
export var health_capacity = 50
export var speed = 150
export var damage = 20
var potential_targets = []
var target
var bodies_in_attack_range = []

func _process(delta):
	if $attack_timer.is_stopped():
		attack_targets_in_range()

func _physics_process(delta):
	if target && target.get_ref():
		var v = (target.get_ref().global_position - global_position).normalized() * speed
		if v.x >= 0: $sprite.flip_h = false
		else: $sprite.flip_h = true
		var collision = move_and_slide(v)

func _on_detection_area_body_entered(body):
	if body.has_method('attack'): 
		potential_targets.push_back(weakref(body))
		choose_current_target()

func _on_detection_area_body_exited(body):
	for i in range(potential_targets.size()):
		if potential_targets[i].get_ref() == body: potential_targets.remove(i)
	choose_current_target()

func choose_current_target():
	if potential_targets.size() > 0: 
		target = potential_targets[0]
		$sprite.play('running')

func attack_targets_in_range():
	for i in range(bodies_in_attack_range.size()):
		var body = bodies_in_attack_range[i].get_ref()
		if body && body.has_method('attack'):
			body.attack(damage)
			$sprite.play('attacking')
			$attack_timer.start()
	if $sprite.is_playing() && $sprite.animation == 'attacking':
		yield($sprite, 'animation_finished')
		if target && !target.get_ref(): target = null
		if target: $sprite.play('running')
		else: $sprite.play('waiting')

func _on_attack_area_body_entered(body):
	if body.has_method('attack'): 
		bodies_in_attack_range.push_back(weakref(body))

func _on_attack_area_body_exited(body):
	if body.has_method('attack'):
		for i in range(bodies_in_attack_range.size()):
			if bodies_in_attack_range[i].get_ref() == body:
				bodies_in_attack_range.remove(i)
	if potential_targets.size() == 0: $sprite.play('waiting')

func attack(damage):
	health = clamp(health - damage, 0, health_capacity)
	if health == 0: queue_free()
