extends KinematicBody2D

onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var sprite_anim:Node = get_node("Sprite")

onready var gravity:int = 0
onready var movement_velocity = Vector2.ZERO
onready var velocity = Vector2.ZERO

signal acorn_hit

func _ready():
	sprite_anim.play(node_array[GlobalSettings.level])

func _physics_process(delta):
	velocity = velocity.linear_interpolate(movement_velocity * 10, delta * 15)
	move_and_slide(velocity + Vector2(0, gravity), Vector2(0, -1))

func drop_acorn():
	movement_velocity = Vector2(0, 10)
	if GlobalSettings.level == 3:
		movement_velocity = Vector2(0, 25)
		return
	gravity = randi() % 8 + 4

func _on_AcornHitbox_acorn_hit():
	emit_signal("acorn_hit")
	self.queue_free()
	print ("acorn hit from acorn script")

func _on_AcornWorldHitbox_acorn_hit_ground():
	get_node(str("Audio/", node_array[GlobalSettings.level])).play()
	sprite_anim.playing = false
