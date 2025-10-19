extends Node2D

class_name GridIndicator

var mouse_grid_pos: Vector2i = Vector2i.ZERO


func _process(delta: float) -> void:
	var new_mouse_grid_pos: Vector2i = ManagerGrid.get_mouse_grid_pos()
	if new_mouse_grid_pos != mouse_grid_pos:
		mouse_grid_pos = new_mouse_grid_pos
		global_position = ManagerGrid.get_world_pos(mouse_grid_pos)
