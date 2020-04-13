extends Node

export (NodePath) var _terrainController
onready var terrainController = get_node(_terrainController)
export (NodePath) var _pathFinding
onready var pathFinding = get_node(_pathFinding)

onready var enemyController : MovesLeftRightController = get_node("MovesLeftRight")

var startingPosition : Vector2

func _ready(): 
	enemyController.terrain = terrainController as TerrainController
	enemyController.pathfinding = pathFinding as PathFinding
	if startingPosition:
		enemyController.set_position(startingPosition)
