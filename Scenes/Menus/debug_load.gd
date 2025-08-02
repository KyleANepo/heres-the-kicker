extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(.1).timeout
	GameManager.restart_game()
	SceneTransition.change_scene_dissolve("res://Scenes/Levels/level_1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
