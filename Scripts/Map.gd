extends Node2D
<<<<<<< Updated upstream
=======
var paused = false
>>>>>>> Stashed changes

func _ready():
	var sound_manager = SoundManager

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")
