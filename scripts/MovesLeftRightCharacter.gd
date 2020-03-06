extends Node
class_name MovesLeftRightCharacter

onready var parent : Node2D = get_parent()
onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")
onready var pathfinding : PathFinding = get_node("/root/Game/PathFinding")
onready var position : Position = parent.get_node("Position")

var alerted = false

var direction = Vector2.LEFT

func _ready():
	var starting_position = pathfinding.get_random_free_position()
	set_position(starting_position)
	parent.global_position = terrain.get_global_position_from_map_position(get_position())

func get_position():
	return position.position

func set_position(newPosition: Vector2):
	self.position.position[0] = floor(newPosition[0])
	self.position.position[1] = floor(newPosition[1])

func move():
	var new_position = get_position() + direction
	if not pathfinding.is_tile_free(new_position):
		direction *= -1
		new_position = get_position() + direction
	set_position(new_position)
	self.parent.global_position = terrain.get_global_position_from_map_position(get_position())

func tick():
	if alerted:
		print("Move towards player")
	move()