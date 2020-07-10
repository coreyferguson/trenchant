extends KinematicBody2D

export(int) var health = 2 setget _set_health
export(int) var health_capacity = 2
export(int) var heal_amount = 3
export(int) var speed = 500

enum States { WAITING, MOVING, HEALING }
var current_state = States.WAITING

var current_speed
var target_position

var HealParticles = preload('res://src/game/hostiles/Wisp/HealParticles.tscn')

onready var animated_sprite = $animated_sprite
onready var animation_player = $animation_player
onready var heal_area = $heal_area
onready var heal_delay = $heal_delay
onready var heal_particles = $heal_particles
onready var heal_particles_container = $heal_particles_container
onready var state_change_timer = $state_change_timer
onready var tween = $tween

func _ready():
	var default_state_change_wait_time = state_change_timer.wait_time
	animated_sprite.play('default')
	animation_player.play('waiting')
	state_change_timer.wait_time = randf() * default_state_change_wait_time
	state_change_timer.start()
	state_change_timer.wait_time = default_state_change_wait_time

func _physics_process(delta):
	if current_state == States.MOVING:
		if !current_speed: return
		if !target_position: return
		if global_position.distance_to(target_position) > 5:
			var v = target_position - global_position
			v = v.normalized() * current_speed
			move_and_slide(v)

func attack(damage):
	_set_health(health - damage)
	animated_sprite.play('pulse')
	yield(animated_sprite, 'animation_finished')
	animated_sprite.play('default')
	animation_player.play('waiting')

func _heal():
	current_state = States.HEALING
	heal_delay.start()
	yield(heal_delay, 'timeout')
	var bodies = heal_area.get_overlapping_bodies()
	if bodies.size() == 0: return
	_heal_bodies(bodies)
	animated_sprite.play('pulse')
	yield(animated_sprite, 'animation_finished')
	animated_sprite.play('default')

func _heal_bodies(bodies):
	# remove all previous particles
	var existing_particles = heal_particles_container.get_children()
	for i in range(existing_particles.size()):
		existing_particles[i].queue_free()
	# add particles for each body
	for i in range(bodies.size()):
		if bodies[i].has_method('attack'):
			bodies[i].attack(heal_amount * -1)
			var particles = HealParticles.instance()
			bodies[i].add_child(particles)
			particles.global_position = bodies[i].global_position

func _move():
	current_state = States.MOVING
	animated_sprite.play('default')
	animation_player.play('moving')
	target_position = Game.get_random_spawn_position()
	current_speed = 1
	tween.stop_all()
	tween.interpolate_property(self, 'current_speed', 1, speed, state_change_timer.wait_time, Tween.EASE_IN)
	tween.start()

func _on_state_change_timer_timeout():
	if current_state == States.HEALING: _wait()
	elif current_state == States.WAITING: _move()
	elif current_state == States.MOVING: _heal()

func _set_health(new_health):
	health = clamp(new_health, 0, health_capacity)
	if health == 0: queue_free()
	$health_bar.set_health(health, health_capacity)

func _wait():
	current_state = States.WAITING
	animated_sprite.play('default')
	animation_player.play('waiting')
