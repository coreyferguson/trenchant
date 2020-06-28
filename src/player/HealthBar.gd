extends Control

func set_health(current, maximum):
	$health.rect_size.x = current * rect_size.x / maximum
