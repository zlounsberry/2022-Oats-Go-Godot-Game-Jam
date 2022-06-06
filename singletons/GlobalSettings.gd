extends Node

onready var level:int = 1
onready var plant_counter:int = 0
onready var mushroom_counter:int = 0
onready var hit_points:int = 5

onready var moss_counter:int = 0
onready var fern_counter:int = 0
onready var ginkgo_counter:int = 0
onready var lemon_counter:int = 0

onready var seconds:float = 0
onready var minutes:float = 0
onready var seconds_text:String

func toggle_sfx_volume(volume):
	AudioServer.set_bus_volume_db(1, volume)

func toggle_music_volume(volume):
	AudioServer.set_bus_volume_db(2, volume)
