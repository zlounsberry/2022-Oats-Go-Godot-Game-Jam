extends Control

func _ready():
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("pause"):
		yield(get_tree().create_timer(0.1), "timeout")
		queue_free()
		get_tree().paused = false
