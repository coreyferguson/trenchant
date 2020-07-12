extends Node

var builds = {
	'bow': {
		'hover_panel_content': preload('./items/bow/build/BowHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 2 },
		],
	},
	'campfire': {
		'hover_panel_content': preload('./constructions/campfire/build/CampfireHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 1 },
			{ 'name': 'rock', 'quantity': 1 },
		],
	},
	'sheep_farm': {
		'hover_panel_content': preload('./constructions/sheep_farm/build/SheepFarmHoverPanelContent.tscn'),		'resource_requirements': [
			{ 'name': 'sheep', 'quantity': 1 },
			{ 'name': 'wood', 'quantity': 1 },
		]
	},
	'spear': {
		'hover_panel_content': preload('./items/spear/build/SpearHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 1 },
			{ 'name': 'obsidian', 'quantity': 1 },
		]
	}
}
