extends Node2D

func _ready():
	var zones = Zone.zones_to_explore
	for i in range(zones.size()):
		if zones[i]:
			var node = get_node('area' + str(i))
			node.visible = true
			node.icon = zones[i].icon

func _on_area_trigger(index):
	Zone.go_to_available_zone(index)
