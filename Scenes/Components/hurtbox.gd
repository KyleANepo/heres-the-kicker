extends Area2D

func _on_area_entered(hitbox: Area2D) -> void:
	if owner != hitbox.owner and owner is Entity and hitbox.owner is Entity:
		if owner not in hitbox.hit:
			owner.take_damage(hitbox.get_damage(owner))
