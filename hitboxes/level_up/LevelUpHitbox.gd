extends Area2D

signal level_up

func _on_LevelUp_body_entered(body):
	emit_signal("level_up")
	print("entered levelup")
