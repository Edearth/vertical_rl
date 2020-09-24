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
		move_actor(actor)
		
		if hit_ground(actor):
			actor.is_falling = false
			actor.velocity = Vector2.ZERO
		elif not actor.is_falling:
			actor.velocity.x = 0
			actor.is_falling = true
		
	print("End simulation physics tick")

func move_actor(actor):
	var final_coords = Vector2(actor.coordinates.x + actor.velocity.x, actor.coordinates.y + actor.velocity.y)
	var current_coords = step_through_movement(actor.coordinates, final_coords)
	
	# update coords
	actor.coordinates = current_coords

func step_through_movement(initial_coords, final_coords):
	var current_coords = initial_coords
	while current_coords.x != final_coords.x or current_coords.y != final_coords.y:
		var next_coords = current_coords
		
		if is_vertical_distance_bigger_than_horizontal(initial_coords, final_coords, current_coords):
			if current_coords.x > final_coords.x:
				next_coords.x -= 1
			else:
				next_coords.x += 1
		else:
			if current_coords.y > final_coords.y:
				next_coords.y -= 1
			else:
				next_coords.y += 1
			
		if is_cell_ground(next_coords):
			break
		else:
			current_coords = next_coords
	return current_coords

func is_vertical_distance_bigger_than_horizontal(initial_coords, final_coords, current_coords):
	var y_completion : int = 1 if initial_coords.y == final_coords.y else abs(inverse_lerp(initial_coords.y, final_coords.y, current_coords.y))
	var x_completion : int = 1 if initial_coords.x == final_coords.x else abs(inverse_lerp(initial_coords.x, final_coords.x, current_coords.x))
	print("!!! > y ilerp: "+str(y_completion))
	print("!!! > x ilerp: "+str(x_completion))
	return y_completion if y_completion is int else 1 >= x_completion if x_completion is int else 1

func hit_ground(actor):
	var below_actor = actor.coordinates
	below_actor.y += 1
	return is_cell_ground(below_actor)

func is_cell_ground(coords):
	return map.get_cell(coords.x, coords.y) != TileMap.INVALID_CELL #this will need to be abstracted to check different tile types, probably on its own map thing
