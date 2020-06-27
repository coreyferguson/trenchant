extends Control

func set_health(current, maximum):
	print('current: ' + str(current))
	print('maximum: ' + str(maximum))
	print(str($health.rect_size.x) + ' / ' + str(rect_size.x))
	$health.rect_size.x = current * rect_size.x / maximum
