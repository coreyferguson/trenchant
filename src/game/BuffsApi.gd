extends Node

var local_buffs
var global_buffs

func _ready():
	reset_state()

func add_local_buff(buff_name, source_type, source_name, context=null):
	return _add_buff(local_buffs, buff_name, source_type, source_name, context)

func add_global_buff(buff_name, source_type, source_name, context=null):
	return _add_buff(global_buffs, buff_name, source_type, source_name, context)

func get_local_buff(buff_name, source_type, source_name):
	return _get_buff(local_buffs, buff_name, source_type, source_name)

func get_global_buff(buff_name, source_type, source_name):
	return _get_buff(global_buffs, buff_name, source_type, source_name)

func has_local_buff(buff_name, source_type, source_name):
	if !source_type || !source_name: return _has_buff(local_buffs, buff_name)
	return _has_buff_from_source(local_buffs, buff_name, source_type, source_name)

func has_global_buff(buff_name, source_type=null, source_name=null):
	if !source_type || !source_name: return _has_buff(global_buffs, buff_name)
	return _has_buff_from_source(global_buffs, buff_name, source_type, source_name)

func remove_local_buff(buff_name, source_type, source_name):
	return _remove_buff(local_buffs, buff_name, source_type, source_name)

func remove_global_buff(buff_name, source_type, source_name):
	return _remove_buff(global_buffs, buff_name, source_type, source_name)

func _add_buff(buffs, buff_name, source_type, source_name, context):
	if _has_buff_from_source(buffs, buff_name, source_type, source_name): return
	if !buffs.has(buff_name): buffs[buff_name] = []
	buffs[buff_name].push_back(\
		{ 'type': source_type, 'name': source_name, 'context': context })

func _get_buff(buffs, buff_name, source_type, source_name):
	if !buffs[buff_name]: return null
	for i in range(buffs[buff_name].size()):
		var source = buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			return buffs[buff_name][i]
	return null

func _has_buff(buffs, buff_name):
	if !buffs.has(buff_name): return false
	return buffs[buff_name].size() > 0

func _has_buff_from_source(buffs, buff_name, source_type, source_name):
	if !buffs.has(buff_name): return false
	for i in range(buffs[buff_name].size()):
		var source = buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			return true
	return false

func _remove_buff(buffs, buff_name, source_type, source_name):
	for i in range(buffs[buff_name].size()):
		var source = buffs[buff_name][i]
		if source.type == source_type && source.name == source_name:
			buffs[buff_name].remove(i)
			return

func reset_state():
	local_buffs = {}
	global_buffs = {}
