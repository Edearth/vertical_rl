extends Node
class_name PathFinding

onready var terrain : TerrainController = get_node("/root/Game/Terrain/TerrainController")

#func _ready():
#	pass

func is_tile_free(position : Vector2):
	return terrain.get_tile(position) != -1
	
func has_ground_beneath(position : Vector2):
	return terrain.get_tile(position + Vector2.DOWN) != -1
