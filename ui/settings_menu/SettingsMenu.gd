extends Control

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		self.queue_free()
