extends Node2D
class_name Level

onready var Player:Object = load("res://characters/player/Player.tscn")
# Borrowing this for sound lol
onready var player:Object = Player.instance()

onready var Pause:Object = load("res://ui/pause/Pause.tscn")
# Borrowing this for sound lol

onready var current_plant_count:int = GlobalSettings.plant_counter
onready var current_mushroom_count:int = GlobalSettings.mushroom_counter

onready var animationplayer:Node = get_node("AnimationPlayer")

onready var mushroom_array:Array = []
onready var plant_array:Array = []
onready var acorn_spawn_array:Array = []

# Array format: [max_x_position:end of level x, high_y_position, low_y_position
onready var position_array:Array =	[
	[
		3750,
		-32,
		150,
	],
	[
		6200,
		-100,
		175,
	],
	[
		6200,
		-100,
		175,
	],
	[
		14000,
		-100,
		445,
	],
]
	
onready var max_x_position:int = position_array[GlobalSettings.level][0]
onready var high_y_position:int = position_array[GlobalSettings.level][1]
onready var low_y_position:int = position_array[GlobalSettings.level][2]

func _ready():
	# todo change to 5
	get_tree().paused = false
	GlobalSettings.hit_points = 5
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.one_shot = false
	timer.connect("timeout", self, "update_clock")
	add_child(timer)
	timer.start()

func _input(event):
	if event.is_action_pressed("pause"):
		var pause:Object = Pause.instance()
		pause.rect_position = Vector2(-50,-50)
		add_child(pause)

func spawn_mushrooms(Player:Object, Mushroom:Object, min_x_position:int, max_x_position:int):
	for high_mushrooms in range(1, 15):
		randomize()
		var mushroom_position:Vector2 = Vector2(randi() % max_x_position, high_y_position)
		if not mushroom_array.has(mushroom_position):
			var mushroom = Mushroom.instance()
			mushroom.position = mushroom_position
			mushroom.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(mushroom)
			mushroom_array.append(mushroom_position)
	for low_mushrooms in range(1, 5):
		randomize()
		var mushroom_position = Vector2(randi() % max_x_position, low_y_position)
		if not mushroom_array.has(mushroom_position):
			var mushroom = Mushroom.instance()
			mushroom.position = mushroom_position
			mushroom.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(mushroom)
			plant_array.append(mushroom_position)

func spawn_plants(Player:Object, Plant:Object, min_x_position:int, max_x_position:int):
	for high_plants in range(1, 24):
		randomize()
		var plant_position = Vector2(randi() % max_x_position, high_y_position)
		if not plant_array.has(plant_position):
			var plant = Plant.instance()
			plant.position = plant_position
			plant.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(plant)
			plant_array.append(plant_position)
	for low_plants in range(1, 8):
		randomize()
		var plant_position = Vector2(randi() % max_x_position, low_y_position)
		if not plant_array.has(plant_position):
			var plant = Plant.instance()
			plant.position = plant_position
			plant.connect("picked_up", self, "play_player_pickup_sound", [Player])
			self.add_child(plant)
			plant_array.append(plant_position)

func create_acorn_spawn_sites(Acorn_spawn_hitbox:Object, Acorn:Object, max_x_position:int):
	for acorn_spawns in range(1, 25):
		randomize()
		var spawn_point_position = Vector2(randi() % max_x_position, low_y_position)
		if not acorn_spawn_array.has(spawn_point_position):
			var acorn = Acorn.instance()
			if GlobalSettings.level == 3:
				acorn.position = Vector2(spawn_point_position.x + (randi() % 225 + 75), high_y_position)
			else:
				acorn.position = Vector2(spawn_point_position.x + (randi() % 125 + 75), high_y_position)
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
	GlobalSettings.hit_points -= 1
	player.play_hit_sound()
	if GlobalSettings.hit_points <=0:
		restart_level(player)

func restart_level(player:Object):
	player.has_health = false
	animationplayer.play("FadeOut")
	yield(animationplayer, "animation_finished")
	GlobalSettings.plant_counter = current_plant_count
	GlobalSettings.mushroom_counter = current_mushroom_count
	get_tree().reload_current_scene()
	
func advance_level(input_level):
	GlobalSettings.level += 1
	animationplayer.play("FadeOut")
	yield(animationplayer, "animation_finished")
	get_tree().change_scene(input_level)

func update_clock():
	GlobalSettings.seconds += 1
	if GlobalSettings.seconds >= 60:
		GlobalSettings.minutes += 1
		GlobalSettings.seconds = 0
	if GlobalSettings.seconds >= 10:
		GlobalSettings.seconds_text = str(GlobalSettings.seconds)
	else:
		GlobalSettings.seconds_text = str("0", GlobalSettings.seconds)
