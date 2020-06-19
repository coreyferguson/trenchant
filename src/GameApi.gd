extends Node

var scenes = {
	'environment': 'res://src/environment/Environment.tscn'
}

func change_scene(scene : String):
	return get_tree().change_scene(scenes[scene])
