extends CanvasLayer

func change_scene_dissolve(target : String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")

func change_scene_wipe(target : String) -> void:
	$AnimationPlayer.play("wipe")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("wipedown")

func change_scene_wipe_reverse(target : String) -> void:
	$AnimationPlayer.play_backwards("wipedown")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("wipe")
