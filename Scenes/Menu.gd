extends Node2D

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")
	
func _on_archives_pressed():
	get_tree().change_scene_to_file("res://Scenes/Archives.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Map.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
