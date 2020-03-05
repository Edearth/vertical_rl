extends Node
class_name TerrainController

export (NodePath) var tiles

var height
var width

func _ready():
	tiles = get_node(tiles) as TileMap

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

func get_position_signs(x_coord: float, y_coord: float):
	var x_sign = 1
	if x_coord != 0:
		x_sign = x_coord / abs(x_coord)
	var y_sign = 1
	if y_coord != 0:
		y_sign = y_coord / abs(y_coord)
	return Vector2(x_sign, y_sign)

func get_map_position_from_global_position(position: Vector2):
	return get_map_position_from_coordinates(position[0], position[1])

func get_map_position_from_coordinates(x_coord: float, y_coord :float):
	var tile_width = tiles.cell_size[0]
	var tile_height = tiles.cell_size[1]
	var x = floor((tiles.position.x + x_coord) / tile_width)
	var y = floor((tiles.position.y + y_coord) / tile_height)
	return Vector2(x, y)

func get_global_position_from_map_position(position: Vector2):
	return get_coordinates_from_map_position(position[0], position[1])

func get_coordinates_from_map_position(x_coord: int, y_coord :int):
	var signs = get_position_signs(x_coord, y_coord)
	var tile_width = tiles.cell_size[0]
	var tile_height = tiles.cell_size[1]
	
	var x = (tile_width * abs(x_coord) + tiles.position.x) * signs[0] + tile_width/2
	var y = (tile_height * abs(y_coord) + tiles.position.y) * signs[1] + tile_height/2

	return Vector2(x, y)
