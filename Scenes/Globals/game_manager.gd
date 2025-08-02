extends Node2D

@export var UI : Control
@export var gametimer : GameTimer
var tornado_unlocked : bool = false
var upkick_unlocked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func restart_game() -> void:
	tornado_unlocked = false
	upkick_unlocked = false
	gametimer.start = true
	UI.show()

func end_game() -> void:
	gametimer.start = true
	UI.show()
