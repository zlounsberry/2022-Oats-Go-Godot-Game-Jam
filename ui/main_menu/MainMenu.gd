extends Control

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("FadeOut")
	var t = Timer.new()
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$HBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	animation_player.play("FadeBlack")
	yield(animation_player, "animation_finished")
	get_tree().change_scene("res://main/Level1/Level1.tscn")
	$AudioStreamPlayer.stop()

func _on_Options_pressed():
	pass # Replace with function body.


func _on_Credits_pressed():
	pass # Replace with function body.
