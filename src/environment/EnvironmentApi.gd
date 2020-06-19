extends Node

func add(child):
	get_node('/root/environment/container').add_child(child)
