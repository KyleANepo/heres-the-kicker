extends Node

func _input(event):
	if event.is_action_pressed("take_screenshot"):
		take_screenshot()

func take_screenshot():
	var timestamp = Time.get_datetime_string_from_system(false, true).replace(":","-")
	var image = get_viewport().get_texture().get_image()
	image.save_png("res://Screenshots/" + timestamp + ".png")
