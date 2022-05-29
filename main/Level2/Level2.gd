extends Level

onready var Player:Object = load("res://characters/player/Player.tscn")
onready var player = Player.instance()

onready var Acorn:Object = load("res://characters/acorn/Acorn.tscn")
onready var AcornSpawnHitbox:Object = load("res://hitboxes/spawn_acorn/SpawnAcornHitbox.tscn")

onready var Mushroom:Object = load("res://objects/mushroom/Mushroom.tscn")
onready var Plant:Object = load("res://objects/plant/Plant.tscn")

func _ready():
	_spawn_player()
	for array_muliplier_values in [
		[player.position.x + 100, max_x_position * 0.333],
		[max_x_position * 0.333, max_x_position * 0.666],
		[max_x_position * 0.666, max_x_position]
	]:
		print(array_muliplier_values)
		spawn_mushrooms(player, Mushroom, array_muliplier_values[0], array_muliplier_values[1])
		spawn_plants(player, Plant,array_muliplier_values[0], array_muliplier_values[1])
	create_acorn_spawn_sites(AcornSpawnHitbox, Acorn, max_x_position)

func _spawn_player():
	player.position = Vector2(0, low_y_position)
	self.add_child(player)