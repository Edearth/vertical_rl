extends Node

onready var input_press = Semaphore.new()
onready var state_machine = StateMachine.new()
var action_taken

func _ready():
	EventBus.connect("player_finished_input", self, "player_finished_input")

func tick():
	input_press.wait()

func player_finished_input():
	input_press.post()

func _process(delta):
	state_machine._process(delta)
