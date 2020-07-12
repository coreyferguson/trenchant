extends Node

var builds = {
	'bow': {
		'hover_panel_content': preload('./items/bow/build/BowHoverPanelContent.tscn'),
		'item_produced_name': 'bow',
		'item_produced_quantity': 20,
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 2 },
		],
	},
	'campfire': {
		'construction_produced_build_scene': preload('./constructions/campfire/build/BuildCampfire.tscn'),
		'hover_panel_content': preload('./constructions/campfire/build/CampfireHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 1 },
			{ 'name': 'rock', 'quantity': 1 },
		],
	},
	'sheep_farm': {
		'construction_produced_build_scene': preload('./constructions/sheep_farm/build/BuildSheepFarm.tscn'),
		'hover_panel_content': preload('./constructions/sheep_farm/build/SheepFarmHoverPanelContent.tscn'),
		'resource_requirements': [
			{ 'name': 'sheep', 'quantity': 1 },
			{ 'name': 'wood', 'quantity': 1 },
		]
	},
	'spear': {
		'hover_panel_content': preload('./items/spear/build/SpearHoverPanelContent.tscn'),
		'item_produced_name': 'spear',
		'item_produced_quantity': 10,
		'resource_requirements': [
			{ 'name': 'wood', 'quantity': 1 },
			{ 'name': 'obsidian', 'quantity': 1 },
		]
	}
}
