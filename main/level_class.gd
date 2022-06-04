extends Node2D
class_name Level

onready var Player:Object = load("res://characters/player/Player.tscn")
# Borrowing this for sound lol
onready var player = Player.instance()

onready var mushroom_array:Array = []
onready var plant_array:Array = []
onready var acorn_spawn_array:Array = []

# Array format: [max_x_position:end of level x, high_y_position, low_y_position
onready var position_array:Array =	[
	[
		3750,
		100,
		150,
	],
	[
		3750,
		100,
		150,
	],
	[
		3750,
		100,
		150,
	],
	[
		3750,
		100,
		150,
	],
]
	
onready var max_x_position:int = position_array[GlobalSettings.level][0]
onready var high_y_position:int = position_array[GlobalSettings.level][1]
onready var low_y_position:int = position_array[GlobalSettings.level][2]

func spawn_mushrooms(Player:Object, Mushroom:Object, min_x_position:int, max_x_position:int):
	for high_mushrooms in range(1, 4):
		randomize()
		var mushroom_position:Vector2 = Vector2(randi() % max_x_position, high_y_position)
		if not mushroom_array.has(mushroom_position):
			var mushroom = Mushroom.instance()
			mushroom.position = mushroom_position
			mushroom.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(mushroom)
			mushroom_array.append(mushroom_position)
	for low_mushrooms in range(1, 1):
		randomize()
		var mushroom_position = Vector2(randi() % max_x_position, low_y_position)
		if not mushroom_array.has(mushroom_position):
			var mushroom = Mushroom.instance()
			mushroom.position = mushroom_position
			mushroom.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(mushroom)
			plant_array.append(mushroom_position)

func spawn_plants(Player:Object, Plant:Object, min_x_position:int, max_x_position:int):
	for high_plants in range(1, 8):
		randomize()
		var plant_position = Vector2(randi() % max_x_position, high_y_position)
		if not plant_array.has(plant_position):
			var plant = Plant.instance()
			plant.position = plant_position
			plant.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(plant)
			plant_array.append(plant_position)
	for low_plants in range(1, 2):
		randomize()
		var plant_position = Vector2(randi() % max_x_position, low_y_position)
		if not plant_array.has(plant_position):
			var plant = Plant.instance()
			plant.position = plant_position
			plant.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(plant)
			plant_array.append(plant_position)

func create_acorn_spawn_sites(Acorn_spawn_hitbox:Object, Acorn:Object, max_x_position:int):
	for acorn_spawns in range(1, 30):
		randomize()
		var spawn_point_position = Vector2(randi() % max_x_position, low_y_position)
		if not acorn_spawn_array.has(spawn_point_position):
			var acorn = Acorn.instance()
			acorn.position = Vector2(spawn_point_position.x + (randi() % 125 + 75), 0)
			acorn.connect("acorn_hit", self, "player_hit", [player])
			self.add_child(acorn)
			var acorn_spawn = Acorn_spawn_hitbox.instance()
			acorn_spawn.position = spawn_point_position
			acorn_spawn.connect("acorn_zone_entered", acorn, "drop_acorn")
			self.add_child(acorn_spawn)
			acorn_spawn_array.append(spawn_point_position)

func play_player_pickup_sound(player:Object):
	player.play_pickup_sound() 

func player_hit(player:Object):
	player.play_hit_sound()
	GlobalSettings.hit_points -= 1
	if GlobalSettings.hit_points <=0:
		print("lol rekt")
