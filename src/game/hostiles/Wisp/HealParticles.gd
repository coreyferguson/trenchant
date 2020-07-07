extends Particles2D

func _ready():
	emitting = true
	$timer.start()

func _on_timer_timeout():
	queue_free()
