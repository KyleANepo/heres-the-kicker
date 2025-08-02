extends Entity
class_name Enemy

func destroy() -> void:
	audio.play_sound(false, 0)
	spark.play_spark("hit")
	queue_free()
