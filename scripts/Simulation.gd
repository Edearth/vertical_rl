extends Node
class_name Simulation

export (NodePath) var terrain
export (NodePath) var tickables
var initialized = false
var load_player_when_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	terrain = get_node(terrain)
	tickables = get_node(tickables)
	initialized = true
	init()
	#if load_player_when_ready:
	#	_on_terrain_init_finished()

func init():
	instantiate_tickable_prefab("res://scenes/Player.tscn")
	for i in range(5):
		instantiate_tickable_prefab("res://scenes/SimpleEnemy.tscn")

func tick():
	for child in tickables.get_children():
		child.propagate_call("tick")

func instantiate_tickable_prefab(path: String):
	var instance = load(path).instance()
	tickables.add_child(instance)

func _on_terrain_init_finished():
	pass
	#if initialized:
	#	init()
	#else:
	#	load_player_when_ready = true
