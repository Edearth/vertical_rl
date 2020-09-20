extends Node
class_name TerrainController

onready var tiles = get_parent().get_node("TileMap") as TileMap

var height
var width

func get_tile(position: Vector2):
	return tiles.get_cell(floor(position[0]), floor(position[1]))

func get_map_size():
	return {
		"top" : -floor(height/2),
		"bottom" : floor(height/2),
		"west" : -floor(width/2),
		"east" : floor(width/2)
	}

func set_tile(position: Vector2, tileValue: int):
	return tiles.set_cell(floor(position[0]), floor(position[1]), tileValue)

func get_map_position_from_global_position(position: Vector2):
	return tiles.world_to_map(position)

func get_global_position_from_map_position(position: Vector2):
	return tiles.map_to_world(position) + tiles.cell_size/2
