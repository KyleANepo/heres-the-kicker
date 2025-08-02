extends Control

@export var tutorial_button : Button
@export var start_button : Button
@export var options_button : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tutorial_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	SceneTransition.change_scene_dissolve("res://Scenes/Menus/debug_load.tscn")


func _on_tutorial_pressed() -> void:
	SceneTransition.change_scene_dissolve("res://Scenes/Levels/level_0.tscn")
