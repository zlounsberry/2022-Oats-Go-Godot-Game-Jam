extends Node2D

onready var Player = load("res://characters/player/Player.tscn")

func _ready():
	var player = Player.instance()
	self.add_child(player)
