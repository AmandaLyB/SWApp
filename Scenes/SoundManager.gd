extends Node2D

var sound_effects: Dictionary = {}
var background_music: AudioStreamPlayer = AudioStreamPlayer.new()

var music_tracks: Array = [
	"res://Audio/Background/starfleet-command-150605.mp3",
	"res://Audio/Background/cinematic-battle-music-star-wars-style-148641.mp3",
	"res://Audio/Background/star-wars-style-march-165111.mp3",
	"res://Audio/Background/war-is-coming-103662.mp3"
]

func _ready():
	if background_music.get_parent() == null:
		background_music.name = "BackgroundMusic"
		add_child(background_music)
		background_music.bus="music"
	
	if !background_music.is_playing():
		var random_track_index = randi() % music_tracks.size()
		var random_music_path = music_tracks[random_track_index]
		play_music(random_music_path)
	
	set_master_volume(0.2)
	set_music_volume(0.2)
	set_effects_volume(0.7)

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
		set_master_volume(float(config_file.get_section_key("Audio", "master_volume", "0.2")))
		set_music_volume(float(config_file.get_section_key("Audio", "music_volume", "0.2")))
		set_effects_volume(float(config_file.get_section_key("Audio", "effects_volume", "0.8")))
