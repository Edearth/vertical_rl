extends Node
class_name PathFinding

onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")

func is_tile_free(position : Vector2):
	var tile = terrain.get_tile(position)
	return tile == -1
	
func has_ground_beneath(position : Vector2):
	return terrain.get_tile(position + Vector2.DOWN) != -1

func has_ground_nearby(position : Vector2):
	for j in range(-1,2):
		for i in range(-1,2):
			var direction = Vector2(j,i)
			if terrain.get_tile(position+direction) != -1:
				return true
	return false