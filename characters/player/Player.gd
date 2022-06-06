extends KinematicBody2D

onready var UI:Object = load("res://ui/on_screen_ui/OnScreenUI.tscn")
onready var ui:Object = UI.instance()

onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var move_speed_array:Array = [0, 1, 1, 2]
onready var ui_position_array:Array = [Vector2(-25, -65),Vector2(-45, -125),Vector2(-45, -125),Vector2(-55, -225)]

onready var jump_multiplier_array:Array = [18, 18, 14, 18]
onready var jump_power:int = jump_multiplier_array[GlobalSettings.level]

onready var gravity_multiplier_array:Array = [10, 10, 7, 10]
onready var gravity_power:int = gravity_multiplier_array[GlobalSettings.level]

onready var hitbox_size_array:Array = [
	[
		Vector2(2,2),
		Vector2(0, 0),
		Vector2(1, 1),
	],
	[
		Vector2(4, 4),
		Vector2(0, 1),
		Vector2(1.5, 2),
	],
	[
		Vector2(4, 6),
		Vector2(0, 2),
		Vector2(1.5, 2.25),
	],
	[
		Vector2(8, 14),
		Vector2(0, 4),
		Vector2(3, 4),
	],
]

onready var current_node:String = node_array[GlobalSettings.level]
onready var sprite_anim:Node = get_node(str(current_node, "/Sprite"))
onready var current_camera:Node = get_node(str(current_node, "/Camera2D"))
onready var current_jump_sound:Node = get_node(str(current_node, "/Jump"))
onready var current_pickup_sound:Node = get_node(str(current_node, "/Pickup"))
onready var current_hit_sound:Node = get_node(str(current_node, "/Hit"))
onready var current_UI:Node = get_node(str(current_node, "/UI"))
onready var movement_speed:int = 5 * (move_speed_array[GlobalSettings.level] + 1)
onready var base_move_speed:int = movement_speed
onready var can_dash:bool = true
onready var coyote_jump:bool = true
onready var has_health = true

func _ready():
	generate_collision_shape()
	resize_player_hitbox()
	ui.rect_position = ui_position_array[GlobalSettings.level]
	add_child(ui)
	current_camera.current = true
	sprite_anim.visible = true
	sprite_anim.play("Run")	

# A lot of this borrowed from Kenney's platformer pack, slightly modified
# Private
var velocity = Vector2(0, 0)
var movement_velocity = Vector2(0, 0)
var gravity = 1
var doubleJump = true

# Methods
func _physics_process(delta):
	if has_health:
		applyControls()
		applyGravity()
		applyAnimation()

		# Apply movement
		velocity = velocity.linear_interpolate(movement_velocity * 10, delta * 15)
		move_and_slide(velocity + Vector2(0, gravity * (GlobalSettings.level + 1)), Vector2(0, -30))

# Player controls
func applyControls():
	movement_velocity = Vector2(0, 0)
	movement_velocity.x = movement_speed

	if is_on_floor():
		coyote_jump = true
		pass

	if Input.is_action_just_pressed("jump"):
		if coyote_jump:
			jump(1)
			current_jump_sound.pitch_scale = 1
			doubleJump = true
			current_jump_sound.play()
		elif doubleJump:
			jump(1)
			current_jump_sound.pitch_scale = 1.35
			doubleJump = false
			current_jump_sound.play()

	if Input.is_action_just_pressed("dash") and GlobalSettings.mushroom_counter > 0:
#		if is_on_floor():
		dash(30)

# Apply gravity and jumping
func applyGravity():
	if gravity <= 100:
		gravity += gravity_power
	
func jump(multiplier):
	coyote_time()
	gravity = -jump_power * multiplier * 10
	sprite_anim.play("Jump")

func dash(multiplier):
	# Make this satisfying, just fast for now
	can_dash = false
	movement_velocity.x = base_move_speed * multiplier
	GlobalSettings.mushroom_counter -= 1
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.one_shot = true
	timer.connect("timeout", self, "return_to_base_speed")
	add_child(timer)
	timer.start()
	ui.populate_on_screen()

# Set animations
func applyAnimation():
	if is_on_floor():
		if abs(velocity.x) > 0:
			sprite_anim.play("Run")
		return
	if not is_on_floor():
		sprite_anim.play("Jump")

# Game jam problems, these functions are poorly named but c'est la jank
func play_pickup_sound():
	ui.populate_on_screen()
	current_pickup_sound.play()

func play_hit_sound():
	ui.populate_on_screen()
	current_hit_sound.play()

func return_to_base_speed():
	movement_velocity.x = base_move_speed
	can_dash = true

func coyote_time():
	yield(get_tree().create_timer(0.1), "timeout")
	coyote_jump = false

func generate_collision_shape():
	var shape = CapsuleShape2D.new()
	var collision_shape = CollisionShape2D.new()
	shape.set_radius(hitbox_size_array[GlobalSettings.level][0][0])
	shape.set_height(hitbox_size_array[GlobalSettings.level][0][1])
	collision_shape.add_to_group("player")
	collision_shape.set_shape(shape)
	collision_shape.position = hitbox_size_array[GlobalSettings.level][1]
	add_child(collision_shape)

func resize_player_hitbox():
	get_node("PlayerHitbox").scale = hitbox_size_array[GlobalSettings.level][2]
