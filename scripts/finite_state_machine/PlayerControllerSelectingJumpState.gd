extends Node

var state_machine
var idle_state = "res://scripts/finite_state_machine/PlayerControllerIdleState.gd"

func on_enter(_stateMachine):
	state_machine = _stateMachine
	print("! Jump where?")
#	update_jump_highlight()

func on_exit():
	print("! Ok.")
#	remove_jump_highlight()

func _process(delta):
	if Input.is_action_just_pressed("wait"):
		print("! You wait.")
		EventBus.emit_signal("player_finished_input")
	elif Input.is_action_just_pressed("cancel"):
		state_machine.change_state(load(idle_state).new())
	
