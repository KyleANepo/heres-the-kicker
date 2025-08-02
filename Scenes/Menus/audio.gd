extends HSlider

enum AudioBusChannels { Master, BGM, SFX } 

func _ready() -> void:
	value = db_to_linear(AudioServer.get_bus_volume_db(AudioBusChannels.Master))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioBusChannels.Master, linear_to_db(value))
