extends Area2D

signal plant_picked_up

func _on_PlantHitbox_area_entered(area):
		emit_signal("plant_picked_up")
