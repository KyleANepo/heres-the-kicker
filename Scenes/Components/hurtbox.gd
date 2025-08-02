extends Area2D

@export var spike_damage : Attack

func _on_area_entered(hitbox: Area2D) -> void:
	if owner != hitbox.owner and owner is Entity and hitbox.owner is Entity:
		if owner not in hitbox.hit:
			owner.take_damage(hitbox.get_damage(owner))

# spikes
func _on_body_entered(_body: Node2D) -> void:
	owner.take_damage(spike_damage)
