extends KinematicBody2D

var health = 2
var speed = 50
var states = [ 'waiting', 'walking', 'eating' ]
var current_state_index = 0
var target_position

func _process(delta):
	if states[current_state_index] == 'walking':
		var v = (target_position - global_position).normalized() * delta * speed
		if v.x >= 0: $sprite.flip_h = false
		else: $sprite.flip_h = true
		move_and_collide(v)

func _on_state_change_timer_timeout():
	current_state_index += 1
	if current_state_index >= states.size(): current_state_index = 0
	if states[current_state_index] == 'walking': 
		$sprite.play('walking')
		target_position = Game.get_random_spawn_position()
	elif states[current_state_index] == 'eating': $sprite.play('eating')
	elif states[current_state_index] == 'waiting': $sprite.play('waiting')

func interact(interactor):
	health -= 1
	if health == 0:
		queue_free()
		return [ { 'name': 'sheep', 'quantity': 1 } ]

func attack(damage):
	health = clamp(health-damage, 0, 2)
	if health == 0:
		queue_free()
		Inventory.collect([{ 'name': 'wool', 'quantity': 1 }])
