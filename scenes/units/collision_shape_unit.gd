extends CollisionShape2D

class_name CollisionShapeUnit

@export var double_click_threshold_milliseconds: int = 500

@onready var unit_test: UnitTest = $".."
var last_click_time: int = 0
var is_mouse_hover: bool = false

signal single_clicked
signal double_clicked


func _ready() -> void:
	unit_test.mouse_entered.connect(on_mouse_entered)
	unit_test.mouse_exited.connect(on_mouse_exited)
	return


func on_mouse_entered() -> void:
	is_mouse_hover = true
	return


func on_mouse_exited() -> void:
	is_mouse_hover = false
	return


func _unhandled_input(event: InputEvent) -> void:
	if not is_mouse_hover:
		return
	if event.is_action_pressed("left_mouse_click"):
		var this_click_time: int = Time.get_ticks_msec()
		if this_click_time - last_click_time < double_click_threshold_milliseconds:
			double_clicked.emit()
		else:
			single_clicked.emit()
		last_click_time = this_click_time
