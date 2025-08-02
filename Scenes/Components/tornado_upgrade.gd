extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.tornado_unlocked:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Bee:
		GameManager.tornado_unlocked = true
		queue_free()
