extends Node2D

var _pressed

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and _pressed:
		global_position += event.relative
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			_pressed = event.pressed
