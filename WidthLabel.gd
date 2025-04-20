extends Label

func _process(delta: float) -> void:
	text = "Width: " + str(BrushSettings.width)
