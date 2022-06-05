extends Control

func _ready():
	$HBoxContainer/Sliders/Sound.focus_mode = 2
	$HBoxContainer/Sliders/Music.focus_mode = 2
	$HBoxContainer/Sliders/Sound.grab_focus()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		self.queue_free()

func _on_Sound_value_changed(value:float):
	GlobalSettings.toggle_sfx_volume(value)

func _on_Music_value_changed(value:float):
	GlobalSettings.toggle_music_volume(value)
