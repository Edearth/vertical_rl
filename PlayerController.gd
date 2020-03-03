extends Node
class_name PlayerController

onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")
onready var pathfinding : PathFinding = get_node("/root/Game/PathFinding")
onready var gravity = get_parent().get_node("AffectedByGravity")

var position : Vector2
var direction : Vector2 = Vector2.ZERO

func _ready():
	self.position = terrain.get_map_position_from_global_position(self.get_parent().global_position)
	self.gravity.entityController = self

func set_movement(movement: Vector2):
	if not gravity.isFalling:
		self.direction = movement.normalized()

func set_jump(jumpSpeed: Vector2):
	if not gravity.isFalling:
		gravity.fallSpeed = jumpSpeed
		gravity.isFalling = true

func move_to_tile_if_free(new_position: Vector2):
	if not pathfinding.is_tile_free(new_position):
		return false
	position = new_position
	self.get_parent().global_position = terrain.get_global_position_from_map_position(position)
	return true

func move():
	var new_position = position + direction
	move_to_tile_if_free(new_position)

func tick():
	if not gravity.isFalling:
		move()
		gravity.calculate_player_falling()
	else:
		gravity.fall()
	
	self.direction = Vector2.ZERO
	
	
	
