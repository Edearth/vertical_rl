extends Node

export var coordinates : Vector2 = Vector2.ZERO
export var display_name : String = "Test"

func _ready():
	var parent = get_parent()
	parent.connect("ready", parent, "set_coordinates", [coordinates])
	
