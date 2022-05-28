extends KinematicBody2D

onready var animation_array:Array = [
	[
		"1bitRun",
		"1bitJump",
		"1bitDash",
	],
	[
		"NESRun",
		"NESJump",
		"NESDash",
	],
	[
		"SNESRun",
		"SNESJump",
		"SNESDash",
	],
	[
		"N64Run",
		"N64Jump",
		"N64Dash",
	]
]


func _ready():
	var current_animation_array:Array = animation_array[GlobalSettings.level]
	print(current_animation_array[0])
	var run_anim:Node = get_node(str(current_animation_array[0]))
	var jump_anim:Node = get_node(str(current_animation_array[1]))
	var dash_anim:Node = get_node(str(current_animation_array[2]))
	run_anim.visible = true
