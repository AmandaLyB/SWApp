extends Node2D

func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://Scenes/GameLevels/Map.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameLevels/Map.tscn")
