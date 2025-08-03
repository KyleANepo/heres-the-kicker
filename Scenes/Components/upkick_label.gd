extends Label

var reveal : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.upkick_unlocked:
		show()
	else:
		hide()


func _on_upkick_upgrade_gotten() -> void:
	show()
