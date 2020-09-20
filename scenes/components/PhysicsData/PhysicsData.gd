extends Node

var velocity : Vector2 = Vector2.ZERO

func _ready():
	get_parent().add_to_group(Groups.PHYSICS)
