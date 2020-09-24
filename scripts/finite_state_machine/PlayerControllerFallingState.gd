extends Node

var player
var map : TileMap
var state_machine

var idle_state = "res://scripts/finite_state_machine/PlayerControllerIdleState.gd"

func on_enter(_stateMachine):
	state_machine = _stateMachine
	map = Singletons.get_instance(Singletons.MAP)
	player = Singletons.get_instance(Singletons.PLAYER)

func on_exit():
	pass

func _process(_delta):
	if not player.is_falling:
		print("! You land.")
		state_machine.change_state(load(idle_state).new())

	if Input.is_action_just_pressed("wait"):
		print("! You wait.")
		EventBus.emit_signal("player_finished_input")
