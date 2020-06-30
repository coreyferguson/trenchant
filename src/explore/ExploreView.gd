extends Node2D

export(Resource) var home_icon

func _ready():
	Zone.connect("zones_to_explore_changed", self, "_redraw_zones")
	Hostile.connect("hostiles_neutralized", self, "_redraw_zones")

func _redraw_zones():
	print(str(Hostile.are_hostiles_neutralized))
	if !Hostile.are_hostiles_neutralized: return
	for i in range(get_children().size()): 
		get_children()[i].disconnect("trigger", self, "_on_area_trigger")
	$home.disconnect("trigger", self, '_on_home_trigger')
	if Zone.has_more_zones():
		var zones = Zone.zones_to_explore
		for i in range(zones.size()):
			if zones[i]:
				var node = get_node('area' + str(i))
				node.visible = true
				node.icon = zones[i].icon
				node.connect("trigger", self, "_on_area_trigger")
	else:
		$home.visible = true
		$home.connect("trigger", self, "_on_home_trigger")

func _on_area_trigger(index):
	Zone.go_to_available_zone(index)

func _on_home_trigger(index):
	Zone.go_home()
