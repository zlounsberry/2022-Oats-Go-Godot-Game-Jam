extends Control

onready var total_score:int = GlobalSettings.moss_counter + GlobalSettings.fern_counter + GlobalSettings.lemon_counter + GlobalSettings.lemon_counter

func _process(delta):
	$VBoxContainer/moss.text = str("Moss foraged: ", GlobalSettings.moss_counter)
	$VBoxContainer/fern.text = str("Ferns (Fiddleheads) foraged: ", GlobalSettings.fern_counter)
	$VBoxContainer/ginkgo.text = str("Gymnosperms (ginkgo) foraged: ", GlobalSettings.ginkgo_counter)
	$VBoxContainer/lemon.text = str("Angiosperms (lemons) foraged: ", GlobalSettings.lemon_counter)
	$VBoxContainer/total.text = str("Total soup ingredients: ", total_score)

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().change_scene("res://ui/main_menu/MainMenu.tscn")
