extends Node

onready var parent = get_parent()
var is_falling : bool = true

func tick():
	if is_falling:
		var vel : Vector2 = parent.velocity
		vel.y += 1
		parent.velocity = vel
