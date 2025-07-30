extends Area2D
class_name Hitbox

@onready var parent = owner
var hit : Array[Entity]

func _process(_delta: float) -> void:
	if $CollisionShape2D.disabled and hit.size() > 0:
		hit.clear()

func get_damage(target : Entity):
	if parent is Entity:
		if target not in hit:
			hit.append(target)
			
			parent.curAttack.direction = parent.look
			parent.curAttack.attackOwner = parent
			return parent.curAttack
