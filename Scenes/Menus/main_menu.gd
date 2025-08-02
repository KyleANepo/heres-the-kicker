extends Control

@export var tutorial_button : Button
@export var start_button : Button
@export var options_button : Button
@export var sfx : Array[AudioStream]
@onready var audio : AudioStreamPlayer2D = $audio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.quit_game()
	tutorial_button.grab_focus()

func _disable_menu():
	for node in get_children():
		if node is Button:
			node.disabled = true
			node.focus_mode = Control.FOCUS_NONE

func _enable_menu():
	for node in get_children():
		if node is Button:
			node.disabled = false
			node.focus_mode = Control.FOCUS_ALL



func _on_start_pressed() -> void:
	_play_audio(1)
	SceneTransition.change_scene_dissolve("res://Scenes/Menus/debug_load.tscn")


func _on_tutorial_pressed() -> void:
	_play_audio(1)
	SceneTransition.change_scene_dissolve("res://Scenes/Levels/level_0.tscn")


func _on_options_pressed() -> void:
	_play_audio(1)
	$Options/OptionsMenu.show()
	$Options/OptionsMenu/Back.grab_focus()
	_disable_menu()

func _on_back_pressed() -> void:
	_play_audio(1)
	$Options/OptionsMenu.hide()
	_enable_menu()
	$Options.grab_focus()
	

func _play_audio(index : int) -> void:
	audio.stream = sfx[index]
	audio.play()

func _on_start_focus_entered() -> void:
	_play_audio(0)


func _on_tutorial_focus_entered() -> void:
	_play_audio(0)


func _on_options_focus_entered() -> void:
	_play_audio(0)


func _on_back_focus_entered() -> void:
	_play_audio(0)


func _on_audio_focus_entered() -> void:
	pass # Replace with function body.
