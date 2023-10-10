extends Node2D

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

var sound_effects: Dictionary = {}
var background_music: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready():
	if background_music.get_parent() == null:
		background_music.name = "BackgroundMusic"
		add_child(background_music)
	background_music.bus = "music"
	background_music.play()
	
	
	# Add sound effects to the dictionary some examples may be
	#sound_effects["explosion"] = load("res://path_to_sound/explosion.wav")
	#sound_effects["pickup"] = load("res://path_to_sound/pickup.wav")

	set_master_volume(1.0)
	set_music_volume(0.8)
	set_effects_volume(0.7)

	background_music.name = "BackgroundMusic"
	add_child(background_music)
	play_music("res://Audio/Background/starfleet-command-150605.mp3")

func play_sound_effect(effect_name: String, volume: float = 1.0):
	if sound_effects.has(effect_name):
		var sound = AudioStreamPlayer.new()
		sound.stream = sound_effects[effect_name]
		sound.volume_db = linear_to_db(volume)
		add_child(sound)
		sound.play()

func play_music(music_path: String):
	background_music.stream = load(music_path)
	background_music.play()

func get_master_volume() -> float:
	return background_music.volume_db

func set_master_volume(volume: float) -> void:
	background_music.volume_db = linear_to_db(volume)

func get_music_volume() -> float:
	return background_music.volume_db

func set_music_volume(volume: float) -> void:
	background_music.volume_db = linear_to_db(volume)

func get_effects_volume() -> float:
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))

func set_effects_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), linear_to_db(volume))

func save_settings() -> void:
	var config_file = ConfigFile.new()
	config_file.set_section_key("Audio", "master_volume", str(get_master_volume()))
	config_file.set_section_key("Audio", "music_volume", str(get_music_volume()))
	config_file.set_section_key("Audio", "effects_volume", str(get_effects_volume()))
	config_file.save("user://audio_settings.cfg")

func load_settings() -> void:
	var config_file = ConfigFile.new()
	if config_file.load("user://audio_settings.cfg") == OK:
		set_master_volume(float(config_file.get_section_key("Audio", "master_volume", "1.0")))
		set_music_volume(float(config_file.get_section_key("Audio", "music_volume", "0.8")))
		set_effects_volume(float(config_file.get_section_key("Audio", "effects_volume", "0.7")))
