extends Node
class_name MovesLeftRight

onready var parent : Node2D = get_parent()
onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")
onready var position : Position = parent.get_node("Position")

var alerted = false

var direction = Vector2.LEFT

func _ready():
	self.position.position = terrain.get_map_position_from_global_position(parent.global_position)

func get_position():
	return position.position

func set_position(new_position: Vector2):
	self.position.position = new_position

func move():
	var new_position = get_position() + direction
	if terrain.get_tile(new_position) != -1:
		direction *= -1
		new_position = get_position() + direction
	set_position(new_position)
	self.parent.global_position = terrain.get_global_position_from_map_position(get_position())

func tick():
	if alerted:
		print("Move towards player")
	move()