extends Node
class_name TerrainController

export (NodePath) var tiles

func _ready():
	tiles = get_node(tiles) as TileMap

func get_tile(position: Vector2):
	return tiles.get_cell(position[0], position[1])

func get_map_position_from_global_position(position: Vector2):
	return get_map_position_from_coordinates(position[0], position[1])

func get_map_position_from_coordinates(x_coord: float, y_coord :float):
	var x = floor(tiles.position.x + x_coord / tiles.cell_size[0]) as int
	var y = floor(tiles.position.y + y_coord / tiles.cell_size[1]) as int
	return Vector2(x, y)

func get_global_position_from_map_position(position: Vector2):
	return get_coordinates_from_map_position(position[0], position[1])

func get_coordinates_from_map_position(x_coord: int, y_coord :int):
	var x = (tiles.position.x + tiles.cell_size[0] * x_coord) + tiles.cell_size[0]/2
	var y = (tiles.position.y + tiles.cell_size[1] * y_coord) + tiles.cell_size[1]/2
	return Vector2(x, y)
