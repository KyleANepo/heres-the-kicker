extends CharacterBody2D
class_name Entity

@onready var flash : AnimationPlayer = $Flash
@onready var sprite : AnimationPlayer = $AnimationPlayer
@export var health = 1
@export var curAttack : Attack

func take_damage(values : Attack) -> void:
	health -= values.damage
	if values.attackOwner is Bee:
		values.attackOwner.attack_successful()
	
	if health <= 0:
		destroy()

func destroy() -> void:
	queue_free()
