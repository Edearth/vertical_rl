extends Node
class_name TerrainGenerator

onready var tiles = get_parent().get_node("TileMap") as TileMap
onready var terrain = get_parent().get_node("TerrainController") as TerrainController
var noise : OpenSimplexNoise

export var height = 40
export var width = 40

var EMPTY_TILE = -1
var WALL_TILE = 0

func _ready():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	generate_map()
	terrain.height = height
	terrain.width = width

func generate_map():
	
	#draw borders
	var border_width = floor(width/2)
	for y in range(-height, height+1):
		print("wall on ("+str(-border_width)+","+str(y)+")")
		print("wall on ("+str(border_width)+","+str(y)+")")
		tiles.set_cell(-border_width, y, WALL_TILE)
		tiles.set_cell(border_width, y, WALL_TILE)
	
	var border_height = floor(height/2)
	for x in range(-width, width+1):
		tiles.set_cell(x, -border_height, WALL_TILE)
		tiles.set_cell(x, border_height, WALL_TILE)
		
	#draw interior
	var interior_height = border_height-1
	var interior_width = border_width-1
	for y in range(-interior_height, interior_height+1):
		for x in range(-interior_width, interior_width+1):
			var hasGround = noise.get_noise_2d(x, y) > 0
			if hasGround:
				tiles.set_cell(x, y, WALL_TILE)
			else:
				tiles.set_cell(x, y, EMPTY_TILE)
	