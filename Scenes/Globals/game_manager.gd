extends Node2D

@export var UI : Control
@export var gametimer : GameTimer
@export var time_up : Control
var tornado_unlocked : bool = false
var upkick_unlocked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.hide()
	time_up.hide()

func restart_game() -> void:
	tornado_unlocked = false
	upkick_unlocked = false
	gametimer.restart()
	var tween = create_tween()
	tween.tween_property(gametimer, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_SINE)
	UI.show()

func timebombed() -> void:
	SceneTransition.change_scene_dissolve("res://Scenes/Levels/level_1.tscn")
	gametimer.restart()

func end_game() -> void:
	gametimer.stop()
	UI.show()

func quit_game() -> void:
	gametimer.stop()
	UI.hide()
