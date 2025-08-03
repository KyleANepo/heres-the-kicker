extends Control

func _start_game() -> void:
	GameManager.restart_game()
	SceneTransition.change_scene_dissolve("res://Scenes/Levels/level_1.tscn")
