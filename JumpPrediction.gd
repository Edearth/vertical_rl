extends Control
class_name JumpPrediction

export (NodePath) var player
export (NodePath) var player_sprite
var sprite_offset : Vector2

func _ready():
	player = get_node(player) as Node2D
	player_sprite = get_node(player_sprite) as Sprite
	sprite_offset = player_sprite.get_rect().size
	sprite_offset.y *= -1

func _draw():
	var start : Vector2 = player.position + sprite_offset
	var speed = Vector2(1,-1) * 1.3
	var color = Color(1.0, 1.0, 1.0)
	draw_parabola(start, speed, color)
	
func draw_parabola(start, speed, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points + 1):
		points_arc.push_back(start + Vector2(speed.x*i*32 - 16, (speed.y + i)*i*32 - 32*i))
	
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)