extends MarginContainer

func _ready():
	Level.connect("level_changed", self, "_on_level_changed")

func _on_level_changed(level):
	$PanelContainer/hbox/value.text = str(level)
