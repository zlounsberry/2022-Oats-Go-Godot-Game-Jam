extends Area2D

signal acorn_zone_entered

func _on_SpawnAcornHitbox_area_entered(area):
	emit_signal("acorn_zone_entered")
	print("Spawn an acorn")
	self.queue_free()
