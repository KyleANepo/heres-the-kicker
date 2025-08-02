extends Node2D

var anim : String 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.call_deferred_thread_group("play", anim)

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

func _rotate() -> void:
	rotation = randf_range(-90, 90)
