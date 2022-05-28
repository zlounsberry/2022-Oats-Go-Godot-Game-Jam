extends Node2D

func _ready():
	if GlobalSettings.level == 0:
		get_node("1Bit").visible = true
		return
	if GlobalSettings.level == 1:
		get_node("NES").visible = true
		get_node("CollisionShape2D").scale = Vector2(2,2)
		return
	if GlobalSettings.level == 2:
		get_node("SNES").visible = true
		get_node("CollisionShape2D").scale = Vector2(4,4)
		return
	if GlobalSettings.level == 3:
		get_node("N64").visible = true
		get_node("CollisionShape2D").scale = Vector2(8,8)
		return
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
