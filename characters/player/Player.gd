extends KinematicBody2D

onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var current_node:String = node_array[GlobalSettings.level]
onready var sprite_anim:Node = get_node(str(current_node, "/Sprite"))
onready var current_camera:Node = get_node(str(current_node, "/Camera2D"))
onready var current_jump_sound:Node = get_node(str(current_node, "/Jump"))
onready var current_pickup_sound:Node = get_node(str(current_node, "/Pickup"))
onready var current_hit_sound:Node = get_node(str(current_node, "/Hit"))


func _ready():
	current_camera.current = true
	sprite_anim.visible = true
	sprite_anim.play("Run")

# A lot of this borrowed from Kenney's platformer pack, slightly modified
export var movementSpeed = 5
export var gravityPower = 10
export var jumpPower = 18

# Private
var velocity = Vector2(0, 0)
var movementVelocity = Vector2(0, 0)
var gravity = 1
var doubleJump = true

# Methods
func _physics_process(delta):
	applyControls()
	applyGravity()
	applyAnimation()

	# Apply movement
	velocity = velocity.linear_interpolate(movementVelocity * 10, delta * 15)
	move_and_slide(velocity + Vector2(0, gravity), Vector2(0, -1))

# Player controls
func applyControls():
	movementVelocity = Vector2(0, 0)
	movementVelocity.x = movementSpeed

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump(1)
			current_jump_sound.pitch_scale = 1
			doubleJump = true
			current_jump_sound.play()
		elif doubleJump:
			jump(1)
			current_jump_sound.pitch_scale = 1.35
			doubleJump = false
			current_jump_sound.play()

# Apply gravity and jumping
func applyGravity():
	if gravity <= 100:
		gravity += gravityPower
	
func jump(multiplier):
	gravity = -jumpPower * multiplier * 10
	sprite_anim.play("Jump")

# Set animations
func applyAnimation():
	if is_on_floor():
		if abs(velocity.x) > 0:
			sprite_anim.play("Run")
		return
	if not is_on_floor():
		sprite_anim.play("Jump")

func play_pickup_sound():
	print("playing pickup sound")
	current_pickup_sound.play()

func play_hit_sound():
	print("playing hit sound")
	current_hit_sound.play()
