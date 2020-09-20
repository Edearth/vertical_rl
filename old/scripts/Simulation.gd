extends Node
class_name Simulation

export (NodePath) var _terrainController
onready var terrainController = get_node(_terrainController)
export (NodePath) var _pathFinding
onready var pathFinding = get_node(_pathFinding)
export (NodePath) var _tickables
onready var tickables = get_node(_tickables)
export (NodePath) var _playerController
onready var playerController = get_node(_playerController)

var initialized = false
var load_player_when_ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5):
		initializeEnemy()
	initializePlayer()
	# BUG: player doesn't snap to the grid on start.
	# Next 2 ticks set the player on the right position
	tick()
	tick()

func initializePlayer():
	var starting_position = pathFinding.get_random_free_position()
	print(starting_position)
	playerController.set_position(starting_position)

func initializeEnemy():
	var enemy = load("res://scenes/Enemies/SimpleEnemy/SimpleEnemy.tscn").instance()
	enemy._terrainController = terrainController.get_path()
	enemy._pathFinding = pathFinding.get_path()
	var starting_position = pathFinding.get_random_free_position()
	enemy.startingPosition = starting_position
	tickables.add_child(enemy)

func tick():
	for child in tickables.get_children():
		child.propagate_call("tick")

func instantiate_tickable_prefab(path: String):
	var instance = load(path).instance()
	tickables.add_child(instance)
	return instance
