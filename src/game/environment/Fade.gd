tool
extends Control

signal finished

export(Color) var fade_color = Color(0, 0, 0, 0)
export(float) var fade_out_alpha = 1.0
export(float) var fade_in_alpha = 0.0

var current_color : Color
var is_drawing = false

func _ready():
	current_color = new_color(fade_out_alpha)
	if !Engine.editor_hint: visible = true

func _process(delta):
	if is_drawing: update()

func _draw():
	draw_rect(Rect2(rect_position, rect_size), current_color)

func fade_out():
	is_drawing = true
	current_color = new_color(fade_in_alpha)
	var tween = $tween
	tween.interpolate_method(
		self, '_update_current_color', fade_in_alpha, fade_out_alpha, 1)
	tween.start()
	tween.interpolate_callback(self, tween.get_runtime(), "_stop_fading")

func fade_in():
	is_drawing = true
	current_color = new_color(fade_out_alpha)
	var tween = $tween
	tween.interpolate_method(
		self, '_update_current_color', fade_out_alpha, fade_in_alpha, 1)
	tween.start()
	tween.interpolate_callback(self, tween.get_runtime(), "_stop_fading")
	
func _update_current_color(alpha : float):
	current_color = new_color(alpha)

func _stop_fading():
	is_drawing = false
	emit_signal("finished")

func new_color(alpha : float):
	return Color(fade_color.r, fade_color.g, fade_color.b, alpha)
