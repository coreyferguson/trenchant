extends GridContainer

var ZoneScene = preload("res://src/explore/Zone.tscn")

func _ready():
	redraw_zone_selections()
	Zone.connect("available_zones_changed", self, 'redraw_zone_selections')

func redraw_zone_selections():
	var children = get_children()
	for i in range(children.size()): children[i].queue_free()
	for i in range(Zone.available_zones.size()):
		if Zone.available_zones[i]:
			var zone = ZoneScene.instance()
			zone.icon = Zone.available_zones[i].icon
			zone.name = Zone.available_zones[i].name
			zone.index = i
			zone.connect("selected", self, '_on_zone_selected')
			add_child(zone)

func _on_zone_selected(index):
	Zone.go_to_available_zone(index)
