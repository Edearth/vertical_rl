extends Node

onready var view = get_node("../View")
onready var data = get_node("../Data")

export (int) var width = 10
export (int) var height = 10

export (OpenSimplexNoise) var noise

func _ready():
	var wall = data.WALL_TILE.tileset_id
	#draw borders
	for y in range(-height, height+1):
		view.set_cell(-width, y, wall)
		view.set_cell(width, y, wall)
	for x in range(-width, width+1):
		view.set_cell(x, -height, wall)
		view.set_cell(x, height, wall)
	view.set_cell(0,0,wall)

#draw interior
	var interior_height = height-1
	var interior_width = width-1
	for y in range(-interior_height, interior_height+1):
		for x in range(-interior_width, interior_width+1):
			var hasGround = noise.get_noise_2d(x, y) > 0
			if hasGround:
				view.set_cell(x, y, wall)
			else:
				view.set_cell(x, y, data.EMPTY_TILE.tileset_id)
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
