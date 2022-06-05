extends Level

onready var Acorn:Object = load("res://characters/acorn/Acorn.tscn")
onready var AcornSpawnHitbox:Object = load("res://hitboxes/spawn_acorn/SpawnAcornHitbox.tscn")

onready var Mushroom:Object = load("res://objects/mushroom/Mushroom.tscn")
onready var Plant:Object = load("res://objects/plant/Plant.tscn")

func _ready():
	get_tree().paused = false
	_spawn_player()
	spawn_mushrooms(player, Mushroom, 500, max_x_position)
	spawn_plants(player, Plant, 500, max_x_position)
	create_acorn_spawn_sites(AcornSpawnHitbox, Acorn, max_x_position)

func _spawn_player():
	animationplayer.play("FadeIn")
	yield(animationplayer, "animation_finished")
	player.position = Vector2(0, low_y_position)
	self.add_child(player)

func _on_LevelUp_level_up():
	advance_level("res://main/Level2/Level2.tscn")
