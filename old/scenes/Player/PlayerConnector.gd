extends Node
class_name PlayerConnector

export (NodePath) var _terrainController
onready var terrainController = get_node(_terrainController)

export (NodePath) var _pathFinding
onready var pathFinding = get_node(_pathFinding)

onready var playerController = get_node("PlayerController")
onready var affectedByGravity = get_node("AffectedByGravity")

func _ready():
	playerController.terrain = terrainController as TerrainController
	playerController.pathfinding = pathFinding as PathFinding
	var startingPosition = pathFinding.get_random_free_position()
	playerController.set_position(startingPosition)
	
	affectedByGravity.entityController = playerController
	affectedByGravity.pathfinding = pathFinding as PathFinding
