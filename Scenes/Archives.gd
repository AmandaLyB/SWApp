extends Node2D

func _ready():
	var sound_manager = SoundManager

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
