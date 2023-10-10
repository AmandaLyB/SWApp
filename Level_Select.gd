extends Node2D

func _ready():
	var sound_manager = SoundManager

func _on_level1_pressed():
	get_tree().change_scene_to_file("res://Scenes/Intro_Cinematic.tscn")
	
	
#func _on_level2_pressed():
#
#
#func _on_level3_pressed():
#
#
#func _on_level4_pressed():
	

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
