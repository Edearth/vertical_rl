extends Node
class_name MovesLeftRight

onready var parent : Node2D = get_parent()
onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")

var alerted = false
var position : Vector2
var direction = Vector2.LEFT

func _ready():
	self.position = terrain.get_map_position_from_global_position(parent.global_position)

func move():
	var new_position = position + direction
	if terrain.get_tile(new_position) != -1:
		direction *= -1
		new_position = position + direction
	position = new_position
	self.parent.global_position = terrain.get_global_position_from_map_position(position)

func tick():
	if alerted:
		print("Move towards player")
	move()