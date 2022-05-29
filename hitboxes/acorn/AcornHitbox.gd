extends Area2D

signal acorn_hit

func _on_AcornHitbox_area_entered(area):
	if area.is_in_group("player"):
		emit_signal("acorn_hit")
