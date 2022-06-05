extends Area2D

signal level_up

func _on_Node2D_area_entered(area):
	emit_signal("level_up")
