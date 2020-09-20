extends Node

export(NodePath) var _actors 
onready var actors = get_node(_actors)
onready var map : TileMap = Singletons.get_instance(Singletons.MAP)

onready var thread = Thread.new()

func _ready():
	thread.start(self, "run")
	
	for actor in get_tree().get_nodes_in_group(Groups.PHYSICS):
		if hit_ground(actor):
			actor.is_falling = false
			actor.velocity.y = 0

# We need to set a dummy parameter if we want to start the method in a Thread
# The start() method without data passes an empty array as data
# See: https://github.com/godotengine/godot/issues/9924
func run(_parameters):
	while true:
		tick()
		physics_tick()

func tick():
	print("Start simulation tick")
	for actor in actors.get_children():
		actor.tick()
	print("End simulation tick")

func physics_tick():
	print("Start simulation physics tick")
	for actor in get_tree().get_nodes_in_group(Groups.PHYSICS):
		#update position
		actor.coordinates += actor.velocity
		
		if hit_ground(actor):
			actor.is_falling = false
			actor.velocity = Vector2.ZERO
		elif not actor.is_falling:
			actor.velocity.x = 0
			actor.is_falling = true
		
	print("End simulation physics tick")

func hit_ground(actor):
	var below_actor = actor.coordinates
	below_actor.y += 1
	return map.get_cell(below_actor.x, below_actor.y) != TileMap.INVALID_CELL #this will need to be abstracted to check different tile types, probably on its own map thing
