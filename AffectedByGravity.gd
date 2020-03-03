extends Node

var entityController # set by controller

var isFalling = false
var gravity = Vector2.DOWN # tile / turn
var fallSpeed = Vector2.DOWN

func fall():
	var speedValue = floor(fallSpeed.length())
	for i in range(speedValue):
		var new_position = entityController.position + fallSpeed.normalized()
		var movedToNewPosition = entityController.move_to_tile_if_free(new_position)
		if not movedToNewPosition:
			entityController.move_to_tile_if_free(entityController.position + gravity)
	fallSpeed += gravity
	
func calculate_player_falling():
	if entityController.pathfinding.has_ground_beneath(entityController.position):
		isFalling = false
		fallSpeed = Vector2.DOWN
	else:
		isFalling = true