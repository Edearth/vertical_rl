extends Node
class_name PlayerController

onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")
onready var pathfinding : PathFinding = get_node("/root/Game/PathFinding")
onready var gravity = get_parent().get_node("AffectedByGravity")
onready var position : Position = get_parent().get_node("Position")
onready var stats : Stats = get_parent().get_node("Stats")

var direction : Vector2 = Vector2.ZERO

func _ready():
	self.set_position(terrain.get_map_position_from_global_position(self.get_parent().global_position))
	self.gravity.entityController = self

func get_position():
	return position.position

func set_position(newPosition: Vector2):
	self.position.position = newPosition

func set_movement(movement: Vector2):
	#if not gravity.isFalling:
	self.direction = movement.normalized()

func set_jump(jumpSpeed: Vector2):
	if not gravity.isFalling:
		gravity.fallSpeed = jumpSpeed
		gravity.enabled = true
		gravity.set_grounded(false)

func move_to_tile_if_free(newPosition: Vector2):
	if not pathfinding.is_tile_free(newPosition):
		return false
	set_position(newPosition)
	self.get_parent().global_position = terrain.get_global_position_from_map_position(get_position())
	return true

func grab(grabDirection: Vector2):
	if not pathfinding.is_tile_free(get_position()+grabDirection):
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
		if not pathfinding.has_ground_nearby(get_position()):
			drop()

func move():
	var newPosition = get_position() + direction
	move_to_tile_if_free(newPosition)

func attack():
	var newPosition = get_position() + direction
	var enemy = pathfinding.get_entity_at(newPosition)
	if enemy:
		var enemyStats = enemy.get_node("Stats")
		enemyStats.hp -= self.stats.atk
		print("! You hit the (enemy name) for "+str(self.stats.atk)+" hp.")
		if enemyStats.hp <= 0:
			print("! You kill the (enemy name).")
			enemyStats.get_parent().queue_free()
		return true
	return false

func move_and_attack():
	if not attack():
		var newPosition = get_position() + direction
		move_to_tile_if_free(newPosition)

func tick():
	if not gravity.isFalling:
		if direction != Vector2.ZERO:
			move_and_attack()
		drop_if_climbing_and_no_wall_nearby()
		gravity.calculate_player_falling()
	else:
		if direction != Vector2.ZERO:
			attack()
		gravity.fall()
	
	self.direction = Vector2.ZERO
	
	
	
