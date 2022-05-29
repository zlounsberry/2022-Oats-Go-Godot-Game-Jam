extends Area2D

signal plant_picked_up

func _on_PlantHitbox_body_entered(body):
	emit_signal("plant_picked_up")
