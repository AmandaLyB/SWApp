extends Node2D

var currentCharacterIndex: int = 0
var characterIndexArray: Array = [1, 5, 11, 4, 14, 10, 13, 3, 2, 20]

func _ready():
	$HTTPRequest.connect("character_data_fetched", updateText)
	parseCharacterData(characterIndexArray[currentCharacterIndex])

func parseCharacterData(characterIndex):
	var characterId = characterIndexArray[currentCharacterIndex]
	var apiUrl = "https://swapi.dev/api/people/" + str(characterId) + "/"
	$HTTPRequest.request(apiUrl)

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/Menu.tscn")

func _on_back_pressed():
	currentCharacterIndex -= 1
	if currentCharacterIndex < 0:
		currentCharacterIndex = characterIndexArray.size() - 1
	parseCharacterData(characterIndexArray[currentCharacterIndex])

func _on_next_pressed():
	currentCharacterIndex += 1
	if currentCharacterIndex == characterIndexArray.size():
		currentCharacterIndex = 0
	parseCharacterData(characterIndexArray[currentCharacterIndex])

func updateText(data):
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapiname.text = data["name"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapiheight.text = data["height"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapimass.text = data["mass"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapieye.text = data["eye_color"]
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapibirth.text = data["birth_year"]

	#await get_tree().create_timer(1).timeout
	requestHome(data["homeworld"])

	var characterId = characterIndexArray[currentCharacterIndex]
	if characterId == 1:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/luke.png")
	elif characterId == 5:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/leia2.png")
	elif characterId == 4:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/darthvadar.png")
	elif characterId == 10:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/obiwankenobi2.png")
	elif characterId == 13:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/chewbacca2.png")
	elif characterId == 3:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/r2d2v2.png")
	elif characterId == 20:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/yoda.png")
	elif characterId == 14:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/hansolo.png")
	elif characterId == 11:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/anakin2.png")
	elif characterId == 2:
		$MarginContainer/VBoxContainer/characterText/factionsymbol.texture = load("res://Art/ArchiveCharacters/c3po2.png")

func requestHome(url):
	$HTTPRequestHome.connect("character_data_fetched", updateHome)
	$HTTPRequestHome.request(url)

func updateHome(data):
	$MarginContainer/VBoxContainer/characterText/swapiinfobox/swapihome.text = data["name"]
