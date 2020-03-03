extends Node
class_name PlayerController

onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")
onready var pathfinding : PathFinding = get_node("/root/Game/PathFinding")
onready var gravity = get_parent().get_node("AffectedByGravity")

var position : Vector2
var direction : Vector2 = Vector2.ZERO

func _ready():
	self.position = terrain.get_map_position_from_global_position(self.get_parent().global_position)

func set_movement(movement: Vector2):
	if not gravity.isFalling:
		self.direction = movement.normalized()

func _move_to_tile_if_free(new_position: Vector2):
	if pathfinding.is_tile_free(new_position):
		return false
	position = new_position
	self.get_parent().global_position = terrain.get_global_position_from_map_position(position)
	return true

func move():
	var new_position = position + direction
	_move_to_tile_if_free(new_position)

func fall():
	for i in range(gravity.fallSpeed):
		var new_position = position + Vector2.DOWN 
		_move_to_tile_if_free(new_position)
	gravity.fallSpeed += 1

func calculate_player_falling():
	if pathfinding.has_ground_beneath(position):
		gravity.isFalling = false
		gravity.fallSpeed = 1
	else:
		gravity.isFalling = true

func tick():
	if not gravity.isFalling:
		move()
		calculate_player_falling()
	else:
		fall()
		calculate_player_falling()
	
	self.direction = Vector2.ZERO
	
	
	
