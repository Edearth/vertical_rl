extends Node

# initialized by parent
var pathfinding : PathFinding
var entityController

var enabled = true
var isFalling = false
var gravity = Vector2.DOWN # tile / turn
var fallSpeed = Vector2.DOWN

func normalize_falling_speed(speed:Vector2):
	var result = speed.normalized()*3
	result[0] = round(floor(result[0])/2)
	result[1] = round(floor(result[1])/2)
	return result.normalized()

func find_new_position(position: Vector2, speed: Vector2):
	var test = entityController.terrain.get_global_position_from_map_position(position)
	speed[0] *= entityController.terrain.tiles.cell_size[0]
	speed[1] *= entityController.terrain.tiles.cell_size[1]
	var result = test + speed
	return entityController.terrain.get_map_position_from_global_position(result)

func simulate_fall_tick(fallSimulationValues):
	var speed = fallSimulationValues.speed
	var position = fallSimulationValues.position
	var positionList = fallSimulationValues.positionList
	var bump
	
	var test = find_new_position(position, speed)
	var movement = test - position
	var amount_of_tiles_involved = max(abs(movement[0]), abs(movement[1]))
	for i in range(amount_of_tiles_involved):
		var new_position = position + movement/amount_of_tiles_involved
		if pathfinding.is_tile_free(new_position):
			position = new_position
			positionList.append(position)
		else:
			speed = Vector2.DOWN
			bump = new_position
			break
	speed += gravity
	
	return {
		"position" : position,
		"speed" : speed,
		"positionList" : positionList,
		"bump" : bump
	}
		
func simulate_fall_until_grounded(initialPosition: Vector2, initialSpeed: Vector2):
	var fallSimulationValues = {
		"position" : initialPosition,
		"speed" : initialSpeed,
		"positionList" : [],
		"bump": null
	}
	
	fallSimulationValues = simulate_fall_tick(fallSimulationValues)
	while not pathfinding.has_ground_beneath(fallSimulationValues.position):
		fallSimulationValues = simulate_fall_tick(fallSimulationValues)
	return fallSimulationValues.positionList

func fall():
	if enabled:
		var fallSimulationValues = {
			"position" : entityController.get_position(),
			"speed" : fallSpeed,
			"positionList" : [],
			"bump": null
		}
		fallSimulationValues = simulate_fall_tick(fallSimulationValues)
	
		if fallSimulationValues.bump:
			print("! You bump against something.")
		if len(fallSimulationValues.positionList) > 0:
			entityController.move_to_tile_if_free(fallSimulationValues.positionList[-1])
	
		self.fallSpeed = fallSimulationValues.speed
		calculate_player_falling()

func set_grounded(isOnGround: bool):
	if isOnGround:
		isFalling = false
		fallSpeed = Vector2.DOWN
	else:
		isFalling = true

func calculate_player_falling():
	if enabled:
		if entityController.pathfinding.has_ground_beneath(entityController.get_position()):
			if isFalling:
				print("! You land.")
			set_grounded(true)
		else:
			set_grounded(false)