extends Node

export (NodePath) var tiles
# Called when the node enters the scene tree for the first time.
func _ready():
	tiles = get_node(tiles)
	print(tiles)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
