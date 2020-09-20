extends Node2D

# exposed interface
var coordinates : Vector2 setget set_coordinates, get_coordinates
var velocity : Vector2 setget set_velocity, get_velocity
var is_falling : bool setget set_falling, get_falling

# internals
onready var actor_data = $"ActorData"
onready var physics_data = $"PhysicsData"
onready var gravity_data = $"AffectedByGravity"

onready var map : TileMap = Singletons.get_instance(Singletons.MAP)

func _init():
	Singletons.set_instance(Singletons.PLAYER, self)

func _ready():
	pass
	
func get_coordinates():
	return actor_data.coordinates

func set_coordinates(_coordinates):
	actor_data.coordinates = _coordinates
	self.position = map.map_to_world(_coordinates)

func get_velocity():
	return physics_data.velocity

func set_velocity(_velocity):
	physics_data.velocity = _velocity

func get_falling():
	return gravity_data.is_falling

func set_falling(falling: bool):
	gravity_data.is_falling = falling

func tick():
	for child in get_children():
		if child.has_method("tick"):
			child.tick()
