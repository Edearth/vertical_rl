extends Node
class_name PlayerControllerIdleState

var player
var map : TileMap
var state_machine

var jump_state = "res://scripts/finite_state_machine/PlayerControllerSelectingJumpState.gd"
var falling_state = "res://scripts/finite_state_machine/PlayerControllerFallingState.gd"

func on_enter(_stateMachine):
	state_machine = _stateMachine
	map = Singletons.get_instance(Singletons.MAP)
	player = Singletons.get_instance(Singletons.PLAYER)

func on_exit():
	pass

func _process(_delta):
	if player.is_falling:
		state_machine.change_state(load(falling_state).new())

	if Input.is_action_just_pressed("wait"):
		print("! You wait.")
		EventBus.emit_signal("player_finished_input")
#	elif Input.is_action_just_pressed("up"):
#		player.set_movement(Vector2.UP)
#		input_press.post()
#	elif Input.is_action_just_pressed("down"):
#		player.set_movement(Vector2.DOWN)
#		input_press.post()
	elif Input.is_action_just_pressed("left"):
		var vel = player.get_velocity()
		vel.x = -1
		if is_cell_free(player.coordinates + vel):
			player.set_velocity(vel)
			EventBus.emit_signal("player_finished_input")
	elif Input.is_action_just_pressed("right"):
		var vel = player.get_velocity()
		vel.x = 1
		if is_cell_free(player.coordinates + vel):
			player.set_velocity(vel)
		EventBus.emit_signal("player_finished_input")
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(load(jump_state).new())

func is_cell_free(coord):
	return map.get_cell(coord.x, coord.y) == TileMap.INVALID_CELL
