extends Control

onready var Credits = load("res://ui/credits/Credits.tscn")
onready var Settings = load("res://ui/settings_menu/SettingsMenu.tscn")

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("FadeOut")
	$HBoxContainer/Start.grab_focus()
	GlobalSettings.level = 0
	GlobalSettings.plant_counter = 0
	GlobalSettings.mushroom_counter = 1
	GlobalSettings.hit_points = 5

func _on_Start_pressed():
	animation_player.play("FadeBlack")
	yield(animation_player, "animation_finished")
	get_tree().change_scene("res://main/Level1/Level1.tscn")
	$Tween.interpolate_property($AudioStreamPlayer, "volume_db", 0, -80, 1, 1, Tween.EASE_IN, 0)
	$Tween.start()
	yield($Tween, "tween_completed")
	$AudioStreamPlayer.stop()

func _on_Credits_pressed():
	animation_player.play("FadeBlack")
	yield(animation_player, "animation_finished")
	var credits = Credits.instance()
	add_child(credits)
	animation_player.play("FadeOut")

func _on_Settings_pressed():
	animation_player.play("FadeBlack")
	yield(animation_player, "animation_finished")
	var settings = Settings.instance()
	add_child(settings)
	animation_player.play("FadeOut")

