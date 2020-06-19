extends KinematicBody2D

var speed = 50
var states = [ 'waiting', 'walking', 'eating' ]
var current_state_index = 0
var target_position

func _process(delta):
	if states[current_state_index] == 'walking':
		var v = (target_position - global_position).normalized() * delta * speed
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
	queue_free()
	return [ { 'name': 'sheep', 'quantity': 1 } ]
