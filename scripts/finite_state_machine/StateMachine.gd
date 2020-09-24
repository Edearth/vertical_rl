extends Node
class_name StateMachine

export(Resource) var default_state
var current_state

func _ready():
	current_state = default_state.new()
	current_state.on_enter(self)

func change_state(new_state):
	current_state.on_exit()
	new_state.on_enter(self)
	current_state = new_state

func _process(delta):
	if current_state:
		current_state._process(delta)
