extends Enemy


func destroy() -> void:
	
	MusicPlayer.stop_music()
	audio.play_sound(false, 0)
	audio.play_sound(true, 0)
	spark.play_spark("hit")
	ko = true
	$AnimatedSprite2D.hide()
	GameManager.gametimer.stop()
	Engine.time_scale = .5
	await get_tree().create_timer(2).timeout
	Engine.time_scale = 1
	SceneTransition.change_scene_dissolve("res://Scenes/Menus/win_screen.tscn")
