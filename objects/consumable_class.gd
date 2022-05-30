extends RigidBody2D
class_name Consumable

onready var animation_array:Array = ["1bit","NES","SNES","N64",]
onready var sprite = $Sprite

onready var hitbox_size_array = [
	[
		Vector2(3, 3),
		Vector2(0, 0),
		Vector2(1, 1),
	],
	[
		Vector2(4, 3),
		Vector2(0, 0),
		Vector2(1, 1),
	],
	[
		Vector2(4, 6),
		Vector2(0, 1),
		Vector2(2, 2),
	],
	[
		Vector2(10, 4),
		Vector2(0, 11),
		Vector2(3, 3),
	],
]

signal picked_up

func _ready():
	sprite.play(animation_array[GlobalSettings.level])

func collect_plant():
	GlobalSettings.plant_counter += 1
	emit_signal("picked_up")
	self.queue_free()

func collect_mushroom():
	GlobalSettings.mushroom_counter += 1
	emit_signal("picked_up")
	self.queue_free()

# Thanks to this answer for helping me solve this: https://godotengine.org/qa/816/how-to-create-a-collision-shape-from-code 
func generate_collision_shape():
	var shape = RectangleShape2D.new()
	var collision_shape = CollisionShape2D.new()
	shape.set_extents(hitbox_size_array[GlobalSettings.level][0])
	collision_shape.set_shape(shape)
	collision_shape.position = hitbox_size_array[GlobalSettings.level][1]
	add_child(collision_shape)
	
func resize_plant_hitbox():
	get_node("PlantHitbox").scale = hitbox_size_array[GlobalSettings.level][2]
