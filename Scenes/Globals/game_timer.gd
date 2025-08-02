extends Control
class_name GameTimer

@export var max_time: float = 90.0
@export var time_up : Control
@export var ui : Control
@export var circle : Control
var time: float = max_time
var minutes: int = 0
var seconds: int = 0
var msec: int = 0
var start : bool = false

func _process(delta) -> void:
	if start:
		time -= delta
	msec = floori(fmod(time, 1) * 100)
	seconds = floori(fmod(time, 60))
	minutes = floori(fmod(time, 3600) / 60)
	$Minute.text = "%02d:" % minutes
	$Second.text = "%02d." % seconds
	$MS.text = "%02d" % msec
	
	if time <= 0:
		time = 0
		$Minute.text = "00:"
		$Second.text = "00."
		$MS.text = "00"
		stop()
		timebomb()

func restart() -> void:
	await get_tree().create_timer(.42).timeout
	circle.scale = Vector2(.01, .01)
	time_up.hide()
	time = max_time
	start = true
	set_process(true)

@onready var sounds : AudioStreamPlayer2D = $sounds

func timebomb() -> void:
	var player : Bee = get_tree().get_nodes_in_group("player")[0] as Bee
	player.freeze()
	ui.hide()
	time_up.show()
	await get_tree().create_timer(1).timeout
	sounds.play()
	var tween = create_tween()
	tween.tween_property(circle, "scale", Vector2(20, 20), 2).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback($"../../..".timebombed)

func stop() -> void:
	start = false
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
