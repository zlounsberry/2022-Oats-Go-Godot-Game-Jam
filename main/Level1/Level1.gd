extends Node2D

onready var Player = load("res://characters/player/Player.tscn")

func _ready():
	var player = Player.instance()
	player.position.y = 100
	self.add_child(player)
