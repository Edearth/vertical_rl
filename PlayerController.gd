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
		gravity.enabled = true
		gravity.set_grounded(false)

func move_to_tile_if_free(new_position: Vector2):
	if not pathfinding.is_tile_free(new_position):
		return false
	position = new_position
	self.get_parent().global_position = terrain.get_global_position_from_map_position(position)
	return true

func grab(direction: Vector2):
	if not pathfinding.is_tile_free(self.position+direction):
		gravity.set_grounded(true)
		gravity.enabled = false
		print("! You successfully grab.")
	else:
		print("! There is nothing to grab there!")

func drop():
	print("! You let go.")
	gravity.enabled = true

func drop_if_climbing_and_no_wall_nearby():
	if not gravity.enabled:
		if not pathfinding.has_ground_nearby(position):
			drop()

func move():
	var new_position = position + direction
	move_to_tile_if_free(new_position)

func tick():
	if not gravity.isFalling:
		move()
		drop_if_climbing_and_no_wall_nearby()
		gravity.calculate_player_falling()
	else:
		gravity.fall()
	
	self.direction = Vector2.ZERO
	
	
	
