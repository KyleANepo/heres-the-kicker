extends AudioStreamPlayer2D

var effect : AudioStream

func _ready() -> void:
	stream = effect
	play()
	
func _on_finished() -> void:
	queue_free()
