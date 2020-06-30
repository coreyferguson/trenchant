extends Node2D

var Arrow = preload('./Arrow.tscn')

var arrow_speed = 500

func use():
	var target = get_global_mouse_position()
	var arrow = Arrow.instance()
	Env.add(arrow)
	arrow.global_position = global_position - Vector2(0, 25)
	arrow.velocity = (target - arrow.global_position).normalized() * arrow_speed
	arrow.rotation = arrow.velocity.angle()
