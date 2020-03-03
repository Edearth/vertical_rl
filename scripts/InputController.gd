extends Node
class_name InputController

export (NodePath) var simulation
export (NodePath) var player

func _ready():
	simulation = get_node(simulation)
	player = get_node(player).find_node("PlayerController")
	print(player)

func _process(delta):
	if Input.is_action_just_pressed("wait"):
		print("wait")
		simulation.tick()
	elif Input.is_action_just_pressed("up"):
		player.set_movement(Vector2.UP)
		simulation.tick()
	elif Input.is_action_just_pressed("down"):
		player.set_movement(Vector2.DOWN)
		simulation.tick()
	elif Input.is_action_just_pressed("left"):
		player.set_movement(Vector2.LEFT)
		simulation.tick()
	elif Input.is_action_just_pressed("right"):
		player.set_movement(Vector2.RIGHT)
		simulation.tick()
	#add diagonal movement if needed (for climbing up and down seems nice
	
	
	