extends Node
class_name PathFinding

onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")
onready var tickables : Node = get_node("/root/Game/Tickables")

var FREE_TILE = -1

func is_tile_free(position : Vector2):
	return terrain.get_tile(position) == FREE_TILE

func get_random_free_position():
	var mapSize = terrain.get_map_size()
	while true:
		var random_x = floor(rand_range(mapSize.west, mapSize.east))
		var random_y = floor(rand_range(mapSize.top, mapSize.bottom))
		var random_position = Vector2(random_x, random_y)
		if is_tile_free(random_position):
			return random_position

func has_ground_beneath(position : Vector2):
	return terrain.get_tile(position + Vector2.DOWN) != -1

func has_ground_nearby(position : Vector2):
	for j in range(-1,2):
		for i in range(-1,2):
			var direction = Vector2(j,i)
			if terrain.get_tile(position+direction) != -1:
				return true
	return false

func get_entity_at(position: Vector2):
	for child in tickables.get_children():
		var child_position = child.get_node("Position").position
		if position == child_position:
			return child
	return null