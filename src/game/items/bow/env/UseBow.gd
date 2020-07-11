extends Node2D

var Arrow = preload('./Arrow.tscn')

var arrow_speed = 500
var required_resources = [ { 'name': 'stick', 'quantity': 1 } ]

var has_physics_completed_once = false

func _physics_process(delta):
	if !has_physics_completed_once:
		has_physics_completed_once = true
		return
	if Inventory.has_resources(required_resources):
		Inventory.remove(required_resources)
		var target = get_global_mouse_position()
		var arrow = Arrow.instance()
		Env.add(arrow)
		arrow.global_position = global_position - Vector2(0, 25)
		arrow.velocity = (target - arrow.global_position).normalized() * arrow_speed
		arrow.rotation = arrow.velocity.angle()
	queue_free()
