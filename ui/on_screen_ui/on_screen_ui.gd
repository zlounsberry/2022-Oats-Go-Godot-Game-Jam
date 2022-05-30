extends Control

class_name OnScreenUI

onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var current_node:String = node_array[GlobalSettings.level]
onready var sprite_anim:Node = get_node(str(current_node, "/Sprite"))

func _ready():
	pass # Replace with function body.

func _process(delta):
	print(str(get_node(str(current_node, "/PlantsLabel")), " should be ", GlobalSettings.plant_counter))
	get_node(str(current_node, "/PlantsLabel")).text = str(GlobalSettings.plant_counter)
	get_node(str(current_node, "/MushroomLabel")).text = str(GlobalSettings.mushroom_counter)
	# Try to change this to a grid container with hearts, but a counter for now
	get_node(str(current_node, "/HPLabel")).text = str(GlobalSettings.hit_points)
