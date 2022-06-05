extends Node

onready var level:int = 3
onready var plant_counter:int = 0
onready var mushroom_counter:int = 0
onready var hit_points:int = 5

func toggle_sfx_volume(volume):
	AudioServer.set_bus_volume_db(1, volume)

func toggle_music_volume(volume):
	AudioServer.set_bus_volume_db(2, volume)

onready var moss_counter:int = 0
onready var fern_counter:int = 0
onready var ginkgo_counter:int = 0
onready var lemon_counter:int = 0
