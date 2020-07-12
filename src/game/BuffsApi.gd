extends Node

var active_buffs

func _ready():
	reset_state()

func add_buff(buff_name, source_type, source_name, context=null):
	if _has_buff_from_source(buff_name, source_type, source_name): return
	if !active_buffs.has(buff_name): active_buffs[buff_name] = []
	active_buffs[buff_name].push_back(\
		{ 'type': source_type, 'name': source_name, 'context': context })

func get_buff(buff_name, source_type, source_name):
	if !active_buffs[buff_name]: return null
	for i in range(active_buffs[buff_name].size()):
		var source = active_buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			return active_buffs[buff_name][i]
	return null

func get_buff_count_for_all_sources(buff_name):
	if !active_buffs.has(buff_name): return 0
	return active_buffs[buff_name].size()

func has_buff(buff_name, source_type=null, source_name=null):
	if !source_type || !source_name: return _has_buff(buff_name)
	return _has_buff_from_source(buff_name, source_type, source_name)

func remove_buff(buff_name, source_type, source_name):
	for i in range(active_buffs[buff_name].size()):
		var source = active_buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			active_buffs[buff_name].remove(i)
			return

func _has_buff(buff_name):
	if !active_buffs.has(buff_name): return false
	return active_buffs[buff_name].size() > 0

func _has_buff_from_source(buff_name, source_type, source_name):
	if !active_buffs.has(buff_name): return false
	for i in range(active_buffs[buff_name].size()):
		var source = active_buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			return true
	return false

func reset_state():
	active_buffs = {}
