extends Node
class_name InputController

export (NodePath) var simulation
export (NodePath) var player
onready var highlight_prefab = preload("res://scenes/tools/Highlight.tscn")
onready var highlights = get_node("Highlights")

var selectingJumping = false
var defaultJump = Vector2(1,-1)
var jumpDirection = defaultJump
var jumpRotationGranularity = PI/8
var jumpForce = 1.3

func _ready():
	simulation = get_node(simulation)
	player = get_node(player).find_node("PlayerController")

func update_jump_highlight():
	highlight_clear()
	highlight_jump_trajectory(player.gravity.simulate_fall_until_grounded(player.position, jumpDirection*jumpForce))
	
func highlight_clear():
	for child in highlights.get_children():
		child.queue_free()

func highlight_jump_trajectory(positionList: Array):
	highlight_clear()
	for position in positionList:
		var highlight = highlight_prefab.instance()
		highlights.add_child(highlight)
		highlight.position = player.terrain.get_global_position_from_map_position(position)
	
func select_jump_controls():
	if Input.is_action_just_pressed("up"):
		var current_angle = jumpDirection.angle()/PI
		print(current_angle)
		if current_angle > -0.51 and current_angle < 0.51:
			jumpDirection = jumpDirection.rotated(-jumpRotationGranularity)
		else:
			jumpDirection = jumpDirection.rotated(jumpRotationGranularity)
		update_jump_highlight()
	elif Input.is_action_just_pressed("down"):
		var current_angle = jumpDirection.angle()/PI
		print(current_angle)
		if current_angle > -0.51 and current_angle < 0.51:
			jumpDirection = jumpDirection.rotated(jumpRotationGranularity)
		else:
			jumpDirection = jumpDirection.rotated(-jumpRotationGranularity)
		update_jump_highlight()
	elif Input.is_action_just_pressed("left"):
		jumpDirection[0] = abs(jumpDirection[0]) * -1
		update_jump_highlight()
	elif Input.is_action_just_pressed("right"):
		jumpDirection[0] = abs(jumpDirection[0])
		update_jump_highlight()
	elif Input.is_action_just_pressed("wait"):
		print("! You wait.")
		simulation.tick()
	elif Input.is_action_just_pressed("confirm"):
		highlight_clear()
		selectingJumping = false
		print("! You jump.")
		player.set_jump(jumpDirection*jumpForce)
		jumpDirection = defaultJump
		simulation.tick()

func _process(delta):
	if selectingJumping:
		select_jump_controls()
		return
	
	if Input.is_action_just_pressed("wait"):
		print("! You wait.")
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
	elif Input.is_action_just_pressed("jump"):
		print("! Jump where?")
		selectingJumping = true
		update_jump_highlight()
		return
	#add diagonal movement if needed (for climbing up and down seems nice
	