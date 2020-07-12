extends Node

var buffs

func _ready():
	reset_state()

func add_buff(buff_name, source_type, source_name, context=null):
	if _has_buff_from_source(buff_name, source_type, source_name): return
	if !buffs.has(buff_name): buffs[buff_name] = []
	buffs[buff_name].push_back(\
		{ 'type': source_type, 'name': source_name, 'context': context })

func get_buff(buff_name, source_type, source_name):
	if !buffs[buff_name]: return null
	for i in range(buffs[buff_name].size()):
		var source = buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			return buffs[buff_name][i]
	return null

func has_buff(buff_name, source_type=null, source_name=null):
	if !source_type || !source_name: return _has_buff(buff_name)
	return _has_buff_from_source(buff_name, source_type, source_name)

func remove_buff(buff_name, source_type, source_name):
	for i in range(buffs[buff_name].size()):
		var source = buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			buffs[buff_name].remove(i)
			return

func _has_buff(buff_name):
	if !buffs.has(buff_name): return false
	return buffs[buff_name].size() > 0

func _has_buff_from_source(buff_name, source_type, source_name):
	if !buffs.has(buff_name): return false
	for i in range(buffs[buff_name].size()):
		var source = buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			return true
	return false

func reset_state():
	buffs = {}
