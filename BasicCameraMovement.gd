extends Camera2D

export (float) var SPEED = 1000

func _process(delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		print("Test")
		movement.y -= SPEED*delta
	if Input.is_action_pressed("ui_down"):
		movement.y += SPEED*delta
	if Input.is_action_pressed("ui_left"):
		movement.x -= SPEED*delta
	if Input.is_action_pressed("ui_right"):
		movement.x += SPEED*delta
	self.translate(movement)
