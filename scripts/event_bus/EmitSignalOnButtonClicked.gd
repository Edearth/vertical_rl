extends Button

export(String) var signal_name

func _pressed():
	EventBus.emit_signal(signal_name)
