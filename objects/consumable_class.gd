extends RigidBody2D
class_name Consumable

onready var animation_array:Array = ["1bit","NES","SNES","N64",]
onready var hitbox_scale_array:Array = [1, 2, 2, 4,]
onready var sprite = $Sprite

signal picked_up

func _ready():
	sprite.play(animation_array[GlobalSettings.level])

func collect_plant():
	GlobalSettings.plant_counter += 1
	print("emit signal from plant class")
	emit_signal("picked_up")
	self.queue_free()

func collect_mushroom():
	GlobalSettings.mushroom_counter += 1
	emit_signal("picked_up")
	print("emit signal from plant class")
	self.queue_free()
