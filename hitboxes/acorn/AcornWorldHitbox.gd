extends Area2D

signal acorn_hit_ground

func _on_Node2D_body_entered(body):
	emit_signal("acorn_hit_ground")
	print("acorn hit ground signal sent")
	self.queue_free()
