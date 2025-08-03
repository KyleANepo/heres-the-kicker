extends Node2D

@export var UI : Control
@export var gametimer : GameTimer
@export var time_up : Control
var tornado_unlocked : bool = true
var upkick_unlocked : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.hide()
	time_up.hide()

func restart_game() -> void:
	tornado_unlocked = false
	upkick_unlocked = false
	gametimer.restart()
	await get_tree().create_timer(.8).timeout
	timer_show()
	UI.show()

func timer_show() -> void:
	var tween = create_tween()
	tween.tween_property(gametimer, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_SINE)

func timer_hide() -> void:
	gametimer.position = Vector2(0, -50)

func timebombed() -> void:
	SceneTransition.change_scene_dissolve("res://Scenes/Levels/level_1.tscn")
	await get_tree().create_timer(.8).timeout
	gametimer.restart()
	UI.show()
	timer_hide()
	timer_show()

func end_game() -> void:
	gametimer.stop()
	UI.show()

func quit_game() -> void:
	gametimer.stop()
	UI.hide()
