extends Node2D

# Abstract this to level class
onready var Player:Object = load("res://characters/player/Player.tscn")
onready var player = Player.instance()

onready var Mushroom:Object = load("res://objects/mushroom/Mushroom.tscn")
onready var Plant:Object = load("res://objects/plant/Plant.tscn")

onready var mushroom_array:Array = []
onready var plant_array:Array = []
# This will be unique to each scene post-abstraction
onready var max_x_position:int = 3750
onready var high_y_position:int = 100
onready var low_y_position:int = 150

func _ready():
	player.position.y = 100
	self.add_child(player)
	_spawn_mushrooms(max_x_position)
	_spawn_plants(max_x_position)

func _spawn_mushrooms(max_x_position:int):
	for high_mushrooms in range(1, 25):
		randomize()
		var mushroom_position:Vector2 = Vector2(randi() % max_x_position, high_y_position)
		if not mushroom_array.has(mushroom_position):
			var mushroom = Mushroom.instance()
			mushroom.position = mushroom_position
			mushroom.connect("picked_up", self, "play_player_pickup_sound")
			self.add_child(mushroom)
			mushroom_array.append(mushroom_position)
	for low_mushrooms in range(1, 25):
		randomize()
		var mushroom_position = Vector2(randi() % max_x_position, low_y_position)
		if not mushroom_array.has(mushroom_position):
			var mushroom = Mushroom.instance()
			mushroom.position = mushroom_position
			mushroom.connect("picked_up", self, "play_player_pickup_sound")
			self.add_child(mushroom)
			plant_array.append(mushroom_position)
		

func _spawn_plants(max_x_position:int):
	for high_plants in range(1, 15):
		randomize()
		var plant_position = Vector2(randi() % max_x_position, high_y_position)
		if not plant_array.has(plant_position):
			var plant = Plant.instance()
			plant.position = plant_position
			plant.connect("picked_up", self, "play_player_pickup_sound")
			self.add_child(plant)
			plant_array.append(plant_position)
	for low_plants in range(1, 15):
		randomize()
		var plant_position = Vector2(randi() % max_x_position, low_y_position)
		if not plant_array.has(plant_position):
			var plant = Plant.instance()
			plant.position = plant_position
			plant.connect("picked_up", self, "play_player_pickup_sound")
			self.add_child(plant)
			plant_array.append(plant_position)

func play_player_pickup_sound():
	player.play_pickup_sound()

func play_player_hit_sound():
	player.play_hit_sound()
