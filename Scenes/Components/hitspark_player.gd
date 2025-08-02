extends Node2D
class_name HitsparkPlayer

var Hitspark = preload("res://Scenes/Components/hitspark.tscn")

func play_spark(anim: String):
	var s = Hitspark.instantiate()
	s.transform = $".".global_transform
	s.anim = anim
	if get_tree():
		get_tree().current_scene.add_child(s)

func play_spark_follow(anim: String):
	var s = Hitspark.instantiate()
	s.anim = anim
	add_child(s)
	#s.transform = $".".global_transform
