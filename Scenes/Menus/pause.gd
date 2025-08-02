extends Control

func _ready() -> void:
	resume()

func _input(_wevent: InputEvent) -> void:
	if Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()
		get_viewport().set_input_as_handled()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == false:
		get_viewport().set_input_as_handled()
		pause()

func _disable_menu():
	for node in get_children():
		if node is Button:
			node.disabled = true
			node.focus_mode = Control.FOCUS_NONE

func _enable_menu():
	for node in get_children():
		if node is Button:
			node.disabled = false
			node.focus_mode = Control.FOCUS_ALL

func resume():
	hide()
	get_tree().paused = false
	for node in get_children():
		node.process_mode = Node.PROCESS_MODE_DISABLED
	
func pause():
	show()
	_enable_menu()
	$Resume.grab_focus()
	get_tree().paused = true
	for node in get_children():
		node.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_resume_pressed() -> void:
	resume()


func _on_options_pressed() -> void:
	$Options/OptionsMenu.show()
	$Options/OptionsMenu/Back.grab_focus()
	_disable_menu()


func _on_quit_pressed() -> void:
	$Options/OptionsMenu.visible = false
	resume()
	GameManager.quit_game()
	SceneTransition.change_scene_dissolve("res://Scenes/Menus/main_menu.tscn")


func _on_back_pressed() -> void:
	$Options/OptionsMenu.hide()
	_enable_menu()
	$Options.grab_focus()
