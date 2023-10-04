extends Node2D

var currentCharacterIndex: int = 0
var maxCharacterIndex: int = 82


func _ready():
	$HTTPRequest.connect("character_data_fetched", updateText)
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
	
	
func updateText(data):
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapiname.text = data["name"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapiheight.text = data["height"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapimass.text = data["mass"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapieye.text = data["eye_color"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapibirth.text = data["birth_year"]
	
	#await get_tree().create_timer(1).timeout
	requestHome(data["homeworld"])

func requestHome(url):
	$HTTPRequestHome.connect("character_data_fetched", updateHome)
	$HTTPRequestHome.request(url)
	
func updateHome(data):
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapihome.text = data["name"]
