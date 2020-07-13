extends Node

signal fade_finished

var persisted_nodes = []

func add(child):
	get_node('/root/environment/container').add_child(child)
	if Zone.is_home() && child.has_method('get_persisted_properties'):
		var persisted_properties = child.get_persisted_properties()
		persisted_nodes.push_back(persisted_properties)
		
func add_to_build(child):
	get_node('/root/environment/build_container').add_child(child)
		
func add_to_hud(child):
	get_node('/root/environment/HUD').add_child(child)

func persist_all_nodes():
	persisted_nodes.resize(0)
	var children = get_node('/root/environment/container').get_children()
	for i in range(children.size()):
		if children[i].has_method('get_persisted_properties'):
			var persisted_properties = children[i].get_persisted_properties()
			persisted_nodes.push_back(persisted_properties)

func restore_persisted_nodes():
	var children = get_node('/root/environment/container').get_children()
	for i in range(children.size()): children[i].queue_free()
	for i in range(persisted_nodes.size()):
		var Scene = persisted_nodes[i].scene
		var scene = Scene.instance()
		get_node('/root/environment/container').add_child(scene)
		if scene.has_method('restore_persisted_state'):
			scene.restore_persisted_state(persisted_nodes[i].state)
	persist_all_nodes() # sometimes necessary when new nodes added while restoring

func reset_state():
	persisted_nodes = []

func get_player():
	return get_node('/root/environment/player')

func fade_out():
	Game.is_input_disabled = true
	var fade = get_node('/root/environment/HUD/fade')
	fade.fade_out()
	yield(fade, 'finished')
	Game.is_input_disabled = false
	emit_signal("fade_finished")

func fade_in():
	Game.is_input_disabled = true
	var fade = get_node('/root/environment/HUD/fade')
	fade.fade_in()
	yield(fade, 'finished')
	Game.is_input_disabled = false
	emit_signal("fade_finished")

func set_background(background):
	get_node('/root/environment/background').texture = background
