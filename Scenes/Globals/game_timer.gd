extends Control
class_name GameTimer

@export var max_time: float = 90.0
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

func restart() -> void:
	time = 90.0
	set_process(true)

func stop() -> void:
	start = false
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d.%03d" % [minutes, seconds, msec]
