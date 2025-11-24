extends Node2D

class_name CameraControl

@export var view_lim_left_top: Vector2i = Vector2i(0, 0)
@export var view_lim_right_down: Vector2i = Vector2i(1920 * 2, 1080)
@export var camera_move_speed: float = 1500
@export var max_offset: Vector2 = Vector2(32, 32)
@export var decay: float = 0.2
var trauma: float = 0.0

@onready var camera_2d: Camera2D = $Camera2D
@onready var timer: Timer = $Timer

var lim_left_top: Vector2i
var lim_right_down: Vector2i
var tracking_unit: UnitTest = null
var target_position: Vector2


func _ready() -> void:
	lim_left_top = view_lim_left_top + get_viewport().size / 2
	lim_right_down = view_lim_right_down - get_viewport().size / 2
	global_position = get_viewport().size / 2
	timer.timeout.connect(_on_timer_out)


func _process(delta: float) -> void:
	var camera_mov_direction: Vector2 = Input.get_vector("camera_mov_left", "camera_mov_right", "camera_mov_up", "camera_mov_down").normalized()
	if camera_mov_direction != Vector2.ZERO:
		tracking_unit = null
		target_position = global_position + camera_mov_direction * camera_move_speed * delta
	else:
		if tracking_unit == null:
			return
		target_position = global_position.move_toward(tracking_unit.global_position, camera_move_speed * delta)
	clamp_target_pos()
	track_target()
	process_shake(delta)
	return


func on_unit_double_clicked(unit: UnitTest) -> void:
	tracking_unit = unit
	return


func clamp_target_pos() -> void:
	target_position.x = clamp(target_position.x, lim_left_top.x, lim_right_down.x)
	target_position.y = clamp(target_position.y, lim_left_top.y, lim_right_down.y)
	return


func track_target() -> void:
	global_position = target_position
	return


func on_unit_hit(amount: float) -> void:
	add_shake(amount)
	return


func process_shake(delta: float) -> void:
	if trauma > 1e-4:
		var shake_offset: Vector2 = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1),
		) * trauma * trauma
		camera_2d.offset = shake_offset * max_offset
		trauma = lerp(trauma, 0.0, decay * delta * 100)
	else:
		camera_2d.offset = Vector2.ZERO


func add_shake(amount: float):
	trauma = sign(amount)
	timer.start()
	Engine.time_scale = 0.1


func _on_timer_out():
	Engine.time_scale = 1.0
