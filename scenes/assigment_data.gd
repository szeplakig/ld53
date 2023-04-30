extends Node2D

var file_data = {   
}

func load_json():
	if not FileAccess.file_exists("res://data/assigments.json"):
		return
	var file = FileAccess.open("res://data/assigments.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file_data = data

func _ready():
	load_json()
