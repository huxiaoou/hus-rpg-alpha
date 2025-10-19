extends CharacterBody2D

class_name UnitTest

@export var start_grid: Vector2i

var speed: float = 500
var target_world_pos: Vector2
var grid_pos: Vector2i:
	get:
		return ManagerGrid.get_grid_pos(global_position)
var path: Array[Vector2]


func _ready() -> void:
	target_world_pos = ManagerGrid.get_world_pos(start_grid)
	global_position = ManagerGrid.get_world_pos(start_grid)


func _process(delta: float) -> void:
	if path and not path.is_empty():
		move(path[0], delta)
		if global_position == path[0]:
			path.remove_at(0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):
		var mouse_grid_pos: Vector2i = ManagerGrid.get_mouse_grid_pos()
		target_world_pos = ManagerGrid.get_world_pos(mouse_grid_pos)
		path = ManagerGrid.get_nav_world_path(self.grid_pos, mouse_grid_pos)


func move(target_world_pos: Vector2, delta: float) -> void:
	global_position = global_position.move_toward(target_world_pos, speed * delta)
