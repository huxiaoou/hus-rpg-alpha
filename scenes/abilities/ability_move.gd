extends AbilityBase

class_name AbilityMove

var speed: float = 500
var path: Array[Vector2] = []


func move(_target_world_pos: Vector2, delta: float) -> void:
	unit.global_position = unit.global_position.move_toward(_target_world_pos, speed * delta)


func _process(delta: float) -> void:
	if not is_active:
		return

	if path.is_empty():
		finish()
	else:
		move(path[0], delta)
		if unit.global_position == path[0]:
			path.remove_at(0)


func start(targe_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(targe_grid_pos, _on_ablility_finished)
	path = ManagerGrid.get_nav_world_path(unit.grid_pos, targe_grid_pos)
	return
