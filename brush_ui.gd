extends Control

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("BrushUIToggle"):
		visible = !visible

func _visibility_signal() -> void:
	EventBus.brush_ui_visible.emit(visible)

func _width_toggled(toggled_on: bool) -> void:
	BrushSettings.use_width_curve = toggled_on

func _color_changed(color: Color) -> void:
	BrushSettings.brush_color = color

func _width_changed(value: float) -> void:
	BrushSettings.width = int(round(value))
