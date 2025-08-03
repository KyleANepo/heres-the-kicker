extends CharacterBody2D
class_name Entity

@onready var flash : AnimationPlayer = $Flash
@onready var sprite : AnimationPlayer = $AnimationPlayer
@onready var spark : HitsparkPlayer = $hitspark_player
@onready var audio : SoundPlayer = $sound_player
@export var health = 1
@export var curAttack : Attack
@export var boost : float = 100
var ko : bool = false

func take_damage(values : Attack) -> void:
	if not ko:
		health -= values.damage
		if values.attackOwner is Bee:
			values.attackOwner.attack_successful(boost)
		
		
		if health <= 0:
			call_deferred("destroy")

func destroy() -> void:
	pass
