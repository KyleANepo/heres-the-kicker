extends Label

var reveal : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.tornado_unlocked:
		show()
	else:
		hide()

func _on_tornado_upgrade_gotten() -> void:
	show()
