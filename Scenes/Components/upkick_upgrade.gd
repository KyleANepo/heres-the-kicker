extends Node2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
var got : bool = false
var player : Bee

signal gotten

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.upkick_unlocked:
		queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Bee and not got:
		got = true
		player = area.owner
		_upgrade(area.owner)

func _upgrade(target : Bee) -> void:
	gotten.emit()
	print(target)
	sprite.stop()
	GameManager.gametimer.stop()
	GameManager.upkick_unlocked = true
	target.call_deferred("freeze_with_benefits")
	var tween = create_tween()
	print(target.global_position)
	tween.tween_property(self, "position", Vector2(position.x, position.y - 100), 1.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", target.global_position, 1).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(_finale)

func _finale() -> void:
	$hitspark_player.play_spark("upgrade")
	player.audio.play_sound(false, 5)
	queue_free()
