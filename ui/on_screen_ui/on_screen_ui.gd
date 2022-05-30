extends Control

class_name OnScreenUI

onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var current_node:String = node_array[GlobalSettings.level]
onready var sprite_anim:Node = get_node(str(current_node, "/Sprite"))

func apply_values_to_labels(MushroomLabel:Node, HPLabel:Node):
#	PlantsLabel.text = str("Plants collected: ", GlobalSettings.plant_counter)
	MushroomLabel.text = str("Mushrooms remaining: ", GlobalSettings.mushroom_counter)
	# Try to change this to a grid container with hearts, but a counter for now
	HPLabel.text = str("Hit points remaining: ", GlobalSettings.hit_points)
