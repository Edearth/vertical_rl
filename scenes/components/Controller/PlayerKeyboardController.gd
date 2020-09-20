extends Node

onready var input_press = Semaphore.new()
onready var state_machine = StateMachine.new()
var action_taken

func _ready():
	EventBus.connect("player_finished_input", self, "player_finished_input")

func tick():
	print("Wait for player input")
	input_press.wait()
	print("Player input selected")

func player_finished_input():
	input_press.post()

func _process(delta):
	state_machine._process(delta)
	
	#	elif Input.is_action_just_pressed("grab"):
	#		print("! Grab where?")
	#		selectingGrab = true
	#		return
	#	elif Input.is_action_just_pressed("drop"):
	#		player.drop()
	#		input_press.post()


