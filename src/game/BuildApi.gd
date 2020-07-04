extends Node

var builds = {
	'bow': {
		'hover_panel_content': preload('./items/bow/build/BowHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'stick', 'quantity': 10 },
		],
	},
	'campfire': {
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 2 },
			{ 'name': 'stick', 'quantity': 4 },
			{ 'name': 'rock', 'quantity': 5 },
		],
	},
	'sheep_farm': {
		'resource_requirements': [
			{ 'name': 'sheep', 'quantity': 2 },
			{ 'name': 'wood', 'quantity': 4 },
		]
	},
	'spear': {
		'hover_panel_content': preload('./items/spear/build/SpearHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'stick', 'quantity': 1 },
			{ 'name': 'obsidian', 'quantity': 1 },
		]
	}
}
