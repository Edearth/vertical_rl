extends Node

var state_machine
var idle_state = "res://scripts/finite_state_machine/PlayerControllerIdleState.gd"
var player

var cursor
var cursor_coords

func on_enter(_state_machine):
	state_machine = _state_machine
	player = Singletons.get_instance(Singletons.PLAYER)
	cursor_coords = player.coordinates

	var gui = Singletons.get_instance(Singletons.GUI)
	
	cursor = Cursor.new()
	cursor.set_coord(cursor_coords)
	gui.add_child(cursor)
	print("! Jump where?")

func on_exit():
	cursor.queue_free()

func _process(_delta):
	if Input.is_action_just_pressed("wait"):
		print("! You wait.")
		EventBus.emit_signal("player_finished_input")
	elif Input.is_action_just_pressed("down"):
		cursor_coords.y += 1
		cursor.set_coord(cursor_coords)
	elif Input.is_action_just_pressed("up"):
		cursor_coords.y -= 1
		cursor.set_coord(cursor_coords)
	elif Input.is_action_just_pressed("left"):
		cursor_coords.x -= 1
		cursor.set_coord(cursor_coords)
	elif Input.is_action_just_pressed("right"):
		cursor_coords.x += 1
		cursor.set_coord(cursor_coords)
	elif Input.is_action_just_pressed("confirm"):
		player.velocity = cursor_coords - player.coordinates
		print("jump: "+str(player.velocity))
		EventBus.emit_signal("player_finished_input")
		state_machine.change_state(load(idle_state).new())
	elif Input.is_action_just_pressed("cancel"):
		print("! Ok.")
		state_machine.change_state(load(idle_state).new())

class Cursor extends ColorRect:
	var coord : Vector2
	var map

	func _init():
		color = Color(1.0,0.0,0.0,0.8)
		map = Singletons.get_instance(Singletons.MAP)

	func set_coord(_coord : Vector2):
		coord = _coord
		print("cursor:"+str(_coord))
		
		self.rect_position = map.map_to_world(coord, true)
		self.rect_size = map.cell_size
		update()
		
	func _ready():
		update()
