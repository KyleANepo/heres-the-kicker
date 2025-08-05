extends Node2D

@export_file("*.tscn") var next_level: String
@export var final_door : bool = false
var entered : bool = false
var player : Bee
var activated : bool = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Bee:
		player = area.owner
		entered = true
		$Arrow.show()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.owner is Bee:
		entered = false
		$Arrow.hide()

func _process(_delta: float) -> void:
	if entered and Input.is_action_just_pressed("up") and player.can_control and not activated:
		activated = true
		if final_door:
			GameManager.gametimer.stop()
		GameManager.gametimer.time += .3
		SceneTransition.change_scene_wipe(next_level)
