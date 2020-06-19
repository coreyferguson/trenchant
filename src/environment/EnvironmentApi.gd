extends Node

var persisted_nodes = []

func add(child):
	get_node('/root/environment/container').add_child(child)
	if Zone.is_home() && child.has_method('get_persisted_properties'):
		var persisted_properties = child.get_persisted_properties()
		persisted_nodes.push_back(persisted_properties)

func restore_persisted_nodes():
	var children = get_node('/root/environment/container').get_children()
	for i in range(children.size()): children[i].queue_free()
	for i in range(persisted_nodes.size()):
		var Scene = persisted_nodes[i].scene
		var scene = Scene.instance()
		if scene.has_method('restore_persisted_state'):
				scene.restore_persisted_state(persisted_nodes[i].state)
		get_node('/root/environment/container').add_child(scene)
