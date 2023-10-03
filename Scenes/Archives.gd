extends Node2D

var currentCharacterIndex: int = 0
var maxCharacterIndex: int = 82

func _ready():
	$HTTPRequest.connect("character_data_fetched", doSomething)
	parseCharacterData(currentCharacterIndex)
	
func parseCharacterData(characterIndex):
	var apiUrl = "https://swapi.dev/api/people/" + str(characterIndex +1) + "/"
	$HTTPRequest.request(apiUrl)

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")

func _on_back_pressed():
	currentCharacterIndex -= 1
	if currentCharacterIndex < 0:
		currentCharacterIndex = maxCharacterIndex
	parseCharacterData(currentCharacterIndex)

func _on_next_pressed():
	currentCharacterIndex += 1
	if currentCharacterIndex > maxCharacterIndex:
		currentCharacterIndex = 0
	parseCharacterData(currentCharacterIndex)

func doSomething(data: String):
	$MarginContainer/VBoxContainer/swapiname.text = data
