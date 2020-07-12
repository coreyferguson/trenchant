tool
extends KinematicBody2D

export(Texture) var texture setget _set_texture
export(int) var speed = 500
export(int) var damage = 2
export(float) var range_radius = 500
export(Shape2D) var collision_shape setget _set_collision_shape
export(String) var resource_name_to_consume
export(int) var resource_quantity_to_consume
export(PackedScene) var scene_to_instance_on_drop

var velocity
var max_range_position

func _ready():
	velocity = get_global_mouse_position() - global_position
	velocity = velocity.normalized()
	max_range_position = global_position + (velocity * range_radius)
	velocity = velocity * speed
	if resource_name_to_consume && resource_quantity_to_consume:
		var required_resources = [{
			'name': resource_name_to_consume,
			'quantity': resource_quantity_to_consume
		}]
		if !Inventory.has_resources(required_resources): queue_free()
		else: Inventory.remove(required_resources)

func _physics_process(delta):
	if Engine.editor_hint: return
	var collision = move_and_collide(velocity * delta)
	if collision && collision.collider.has_method('attack'):
		collision.collider.attack(damage)
		_drop_resource()
	elif global_position.distance_to(max_range_position) < 5:
		_drop_resource()

func _drop_resource():
	queue_free()
	if scene_to_instance_on_drop: 
		var inst = scene_to_instance_on_drop.instance()
		inst.global_position = global_position
		Env.add(inst)
	

func _set_collision_shape(new_collision_shape):
	collision_shape = new_collision_shape
	if $collision: $collision.shape = collision_shape

func _set_texture(new_texture):
	texture = new_texture
	if $sprite: $sprite.texture = texture
