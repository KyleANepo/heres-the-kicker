extends AudioStreamPlayer

func play_music(song) -> void:
	stream = song
	play()

func stop_music():
	stop()
	stream = null
