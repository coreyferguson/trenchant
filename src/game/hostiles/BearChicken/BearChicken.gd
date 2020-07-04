extends KinematicBody2D

export var health = 50
export var health_capacity = 50
export var speed = 150
export var damage = 15
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
	var indexes_to_remove = []
	for i in range(potential_targets.size()):
		if potential_targets[i].get_ref() == body: indexes_to_remove.push_back(i)
	indexes_to_remove.invert()
	for i in range(indexes_to_remove.size()):
		potential_targets.remove(indexes_to_remove[i])
	choose_current_target()

func choose_current_target():
	if potential_targets.size() > 0: 
		target = potential_targets[0]
		play('running')

func attack_targets_in_range():
	for i in range(bodies_in_attack_range.size()):
		var body = bodies_in_attack_range[i].get_ref()
		if body && body.has_method('attack'):
			body.attack(damage)
			play('attacking')
			$attack_timer.start()
	if $sprite.is_playing() && $sprite.animation == 'attacking':
		yield($sprite, 'animation_finished')
		if target && !target.get_ref(): target = null
		if target: play('running')
		else: play('waiting')

func _on_attack_area_body_entered(body):
	if body.has_method('attack'): 
		bodies_in_attack_range.push_back(weakref(body))

func _on_attack_area_body_exited(body):
	var indexes_to_delete = []
	if body.has_method('attack'):
		for i in range(bodies_in_attack_range.size()):
			if bodies_in_attack_range[i].get_ref() == body:
				indexes_to_delete.push_back(i)
	indexes_to_delete.invert()
	for i in range(indexes_to_delete.size()):
		bodies_in_attack_range.remove(indexes_to_delete[i])
	if potential_targets.size() == 0: play('waiting')

func attack(damage):
	health = clamp(health - damage, 0, health_capacity)
	if health == 0: queue_free()

func play(animation):
	if $sprite.animation == 'attacking' && $sprite.is_playing():
		yield($sprite, 'animation_finished')
	$sprite.play(animation)
