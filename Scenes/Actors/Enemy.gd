extends Entity
class_name Enemy

func destroy() -> void:
	if not ko:
		audio.play_sound(false, 0)
		spark.play_spark("hit")
		ko = true
		$AnimatedSprite2D.hide()
		await get_tree().create_timer(2).timeout
		health = 1
		$AnimatedSprite2D.show()
		flash.play("respawn")
		spark.play_spark("dust")
		ko = false
