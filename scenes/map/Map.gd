extends Node

func _ready():
	Singletons.set_instance(Singletons.MAP, $TileMap)
