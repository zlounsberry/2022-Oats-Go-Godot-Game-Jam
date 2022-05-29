extends KinematicBody2D

onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var current_node_array:String = node_array[GlobalSettings.level]
onready var sprite_anim:Node = get_node(str(current_node_array, "/Sprite"))
onready var current_camera:Node = get_node(str(current_node_array, "/Camera2D"))


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
	print(gravity)
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
			doubleJump = true
		elif doubleJump:
			jump(1)
			doubleJump = false

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
