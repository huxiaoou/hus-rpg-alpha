extends Node2D

class_name CameraControl

@export var view_lim_left_top: Vector2i = Vector2i(0, 0)
@export var view_lim_right_down: Vector2i = Vector2i(1920 * 2, 1080)
@export var camera_move_speed: float = 500

@onready var camera_2d: Camera2D = $Camera2D

var lim_left_top: Vector2i
var lim_right_down: Vector2i
var tracking_unit: UnitTest = null


func _ready() -> void:
	lim_left_top = view_lim_left_top + get_viewport().size / 2
	lim_right_down = view_lim_right_down - get_viewport().size / 2
	global_position = get_viewport().size / 2


func _process(delta: float) -> void:
	var camera_mov_direction: Vector2 = Input.get_vector("camera_mov_left", "camera_mov_right", "camera_mov_up", "camera_mov_down").normalized()
	if camera_mov_direction != Vector2.ZERO:
		var target_position: Vector2 = global_position + camera_mov_direction * camera_move_speed * delta
		target_position.x = clamp(target_position.x, lim_left_top.x, lim_right_down.x)
		target_position.y = clamp(target_position.y, lim_left_top.y, lim_right_down.y)
		global_position = target_position
		tracking_unit = null
	track_unit()
	return


func on_unit_double_clicked(unit: UnitTest) -> void:
	tracking_unit = unit
	return


func track_unit() -> void:
	if tracking_unit != null:
		global_position.x = clamp(tracking_unit.global_position.x, lim_left_top.x, lim_right_down.x)
		global_position.y = clamp(tracking_unit.global_position.y, lim_left_top.y, lim_right_down.y)
