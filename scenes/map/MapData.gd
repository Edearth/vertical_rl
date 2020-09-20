extends Node
class_name MapData

var tileset = { 
	-1 : Tile.new(-1, true),
	1 : Tile.new(1, false)
}

var EMPTY_TILE = tileset[-1]
var WALL_TILE = tileset[1]

class Tile:
	var tileset_id : int
	var passable : bool
	
	func _init(_tileset_id, _passable):
		self.tileset_id = _tileset_id
		self.passable = _passable
