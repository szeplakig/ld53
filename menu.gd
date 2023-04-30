extends Control

var is_menu_open = false

@onready var quit_button = $Menu/MarginContainer/Panel/VBoxContainer/HBoxContainer/MarginContainer2/QuitButton
@onready var respawn_button = $Menu/MarginContainer/Panel/VBoxContainer/HBoxContainer/MarginContainer/RespawnButton
@onready var toggle_music_button = $Menu/MarginContainer/Panel/VBoxContainer/HBoxContainer/MarginContainer4/ToggleMusicButton
@onready var close_menu_button = $Menu/MarginContainer/Panel/VBoxContainer/HBoxContainer/MarginContainer3/CloseMenuButton
@onready var player = get_node("/root/space/Spaceship")

func _ready():
	show_menu()

	quit_button.pressed.connect(_on_quit_button_pressed)
	respawn_button.pressed.connect(_on_respawn_button_pressed)
	toggle_music_button.pressed.connect(_on_toggle_music_button_pressed)
	close_menu_button.pressed.connect(_on_close_menu_button_pressed)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_menu()

func toggle_menu():
	if is_menu_open:
		hide_menu()
	else:
		show_menu()

func show_menu():
	$Menu.show()
	is_menu_open = true

func hide_menu():
	$Menu.hide()
	is_menu_open = false

func _on_quit_button_pressed():
	if not OS.has_feature("web"):
		get_tree().quit()

func _on_respawn_button_pressed():
	player._respawn()
	hide_menu()

func _on_toggle_music_button_pressed():
	if player.music.playing:
		player.music.stop()
	else:
		player.music.play()

func _on_close_menu_button_pressed():
	hide_menu()
