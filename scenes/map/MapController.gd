extends TileMap

func _ready():
	pass

func is_cell_ground(coords):
	return self.get_cell(coords.x, coords.y) != TileMap.INVALID_CELL
	
