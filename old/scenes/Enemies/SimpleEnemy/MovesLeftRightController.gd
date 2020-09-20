extends Node
class_name MovesLeftRightController

var terrain : TerrainController
var pathfinding : PathFinding

onready var parent : Node2D = get_parent()
onready var position : Position = parent.get_node("Position")

var alerted = false

var direction = Vector2.LEFT

func get_position():
	return position.position

func set_position(newPosition: Vector2):
	self.position.position[0] = floor(newPosition[0])
	self.position.position[1] = floor(newPosition[1])
	parent.global_position = terrain.get_global_position_from_map_position(newPosition)

func move():
	var new_position = get_position() + direction
	if not pathfinding.is_tile_free(new_position):
		direction *= -1
		new_position = get_position() + direction
	set_position(new_position)

func tick():
	if alerted:
		print("Move towards player")
	move()