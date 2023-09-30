extends Node2D

@onready var username = get_node("Control/MarginContainer/HeaderVBox/Label/MarginContainer/VolumeVBox/VBoxContainer/inputUsername")
@onready var password = get_node("Control/MarginContainer/HeaderVBox/Label/MarginContainer/VolumeVBox/VBoxContainer2/inputPassword")
signal get_credentials(name, pw)

# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request("http://localhost:3000/api#/")
	print("connected to back end")
	username.grab_focus()
	password.grab_focus()

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json != null:
		print("connection success")
	else:
		print("JSON was null")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_pressed():
	emit_signal("get_credentials", username.text, password.text)
	queue_free()
	
	print("username: " + username.text)
	print("password: " + password.text)
	if username.text == "aaa" and password.text == "aaa":
		print("Credentials Valid")
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Login.tscn")


func _on_button_pressed():
	get_tree().quit()
