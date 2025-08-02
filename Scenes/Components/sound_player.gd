extends Node2D
class_name SoundPlayer

@export var defaultSFX: Array[AudioStream]
@export var characterSFX: Array[AudioStream]

var sfx = preload("res://Scenes/Components/sound_effect.tscn")
var sound_to_play : AudioStream

func play_sound(character : bool, index : int) -> void:
	if character:
		sound_to_play = characterSFX[index]
	else:
		sound_to_play = defaultSFX[index]
	
	var s = sfx.instantiate()
	s.effect = sound_to_play
	get_tree().current_scene.add_child(s)
	s.transform = $".".global_transform
