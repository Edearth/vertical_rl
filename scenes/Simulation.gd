extends Node

export(NodePath) var _actors 
onready var actors = get_node(_actors)
onready var map : TileMap = Singletons.get_instance(Singletons.MAP)

func _ready():
	EventBus.connect("tick", self, "tick")

func tick():
	print("Start simulation tick")
	for actor in actors.get_children():
		actor.tick()
	physics_tick()
	print("End simulation tick")

func physics_tick():
	print("Start simulation physics tick")
	for actor in get_tree().get_nodes_in_group(Groups.PHYSICS):
		if actor.is_falling and hit_ground(actor):
			actor.is_falling = false
			actor.velocity.y = 0
		
		#update position
		actor.coordinates += actor.velocity
	
	print("End simulation physics tick")

func hit_ground(actor):
	var below_actor = actor.coordinates
	below_actor.y += 1
	return map.get_cell(below_actor.x, below_actor.y) != TileMap.INVALID_CELL #this will need to be abstracted to check different tile types, probably on its own map thing
