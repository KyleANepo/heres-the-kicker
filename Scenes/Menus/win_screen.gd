extends Control

var final_time : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play()
	GameManager.timer_hide()
	var tween = create_tween()
	tween.tween_property($Camera2D, "position", Vector2(320, 180), 4).set_trans(Tween.TRANS_EXPO)
	final_time = GameManager.end_game()
	$Label2.text = final_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
