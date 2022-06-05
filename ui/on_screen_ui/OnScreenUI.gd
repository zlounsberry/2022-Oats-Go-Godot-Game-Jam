extends Control

onready var Mushroom = load("res://ui/on_screen_ui/MushroomGridIcon.tscn")
onready var HP = load("res://ui/on_screen_ui/HPGridIcon.tscn")
onready var node_array:Array = ["1bit","NES","SNES","N64"]
onready var current_node:String = node_array[GlobalSettings.level]
onready var icon_size_array:Array = [Vector2(8,8),Vector2(16,16),Vector2(16,16),Vector2(32,32)]
onready var current_icon_size:Vector2 = icon_size_array[GlobalSettings.level]
onready var mushroom_hbox:Node = get_node("VBoxContainer/MushroomHBox")
onready var hp_hbox:Node = get_node("VBoxContainer/HPHBox")

func _ready():
	populate_grid(hp_hbox, HP, GlobalSettings.hit_points)
	populate_grid(mushroom_hbox, Mushroom, GlobalSettings.mushroom_counter)

func populate_on_screen():
	print("populating on screen")
	populate_grid(hp_hbox, HP, GlobalSettings.hit_points)
	populate_grid(mushroom_hbox, Mushroom, GlobalSettings.mushroom_counter)

func populate_grid(hbox_id:Node, input_object:Object, max_range:int):
	for child in hbox_id.get_children():
			child.queue_free() 
			hbox_id.remove_child(child)
	if max_range > 0:
		for range_count in range(0, max_range):
			var icon_container = MarginContainer.new()
			var icon = input_object.instance()
			icon.get_node("Sprite").play(current_node)
			set_container_size(icon_container, current_icon_size)
			icon_container.add_child(icon)
			hbox_id.add_child(icon_container)

func set_container_size(input_container: MarginContainer, size: Vector2):
	input_container.rect_min_size = size
	input_container.rect_size = size
