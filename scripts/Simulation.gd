extends Node
class_name Simulation

export (NodePath) var terrain
export (NodePath) var inputController
export (NodePath) var tickables

# Called when the node enters the scene tree for the first time.
func _ready():
	terrain = get_node(terrain)
	inputController = get_node(inputController)
	tickables = get_node(tickables)

func tick():
	for child in tickables.get_children():
		child.propagate_call("tick")
