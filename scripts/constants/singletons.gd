extends Node

enum { MAP }

var _instances : Dictionary = {}

func get_instance(key):
	return _instances[key]

func set_instance(key, value):
	_instances[key] = value
