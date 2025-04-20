extends Node2D

@onready var layer := $DrawingLayer
@onready var cursor := $DrawingCursor

var _pan_pressed : bool = false

var drawing_locked : bool = false
var drawing : bool = false
var _current_line : Line2D = null
var _prev_lines : Array = []

func _ready() -> void:
	EventBus.brush_ui_visible.connect(lock)

func _process(delta: float) -> void:
	cursor.global_position = get_global_mouse_position()

func lock(locked : bool) -> void:
	drawing_locked = locked

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			_pan_pressed = event.pressed
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			drawing = event.pressed
		
			if drawing:
				_current_line = Line2D.new()
				#_current_line.global_position = cursor.global_position
				_current_line.default_color = BrushSettings.brush_color
				_current_line.width = BrushSettings.width
				if BrushSettings.use_width_curve: _current_line.width_curve = load("res://width_curve.tres")
				layer.add_child(_current_line)
			elif !drawing:
				_prev_lines.append(_current_line)
	
	if event is InputEventMouseMotion && drawing:
		_current_line.add_point(cursor.global_position)
	
	if event is InputEventMouseMotion && _pan_pressed:
		layer.global_position += event.relative
	
	if event.is_action_pressed("Undo"):
		if _prev_lines.size() > 0:
			var line_to_undo = _prev_lines[-1]
			_prev_lines.remove_at(_prev_lines.size() - 1)
			line_to_undo.queue_free()
