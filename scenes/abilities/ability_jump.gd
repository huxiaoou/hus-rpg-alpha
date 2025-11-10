extends AbilityBase

class_name AbilityJump

@export var speed: float = 1200
var path: Array[Vector2] = []


func move(_target_world_pos: Vector2, delta: float) -> void:
	unit.global_position = unit.global_position.move_toward(_target_world_pos, speed * delta)


func _process(delta: float) -> void:
	if not is_active:
		return

	if path.is_empty():
		finish()
	else:
		if path[0].x > unit.global_position.x:
			unit.animated_sprite_2d.scale.x = 1
		elif path[0].x < unit.global_position.x:
			unit.animated_sprite_2d.scale.x = -1
		move(path[0], delta)
		if unit.global_position == path[0]:
			path.remove_at(0)
			ManagerGrid.visualize_grid(get_ability_grids())


func start(target_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(target_grid_pos, _on_ablility_finished)
	unit.animated_sprite_2d.play("jump")
	path = [ManagerGrid.get_world_pos(unit.grid_pos), ManagerGrid.get_world_pos(target_grid_pos)]
	ManagerGrid.set_grid_walkablity(unit.grid_pos, true)
	ManagerGrid.set_grid_occupant(unit.grid_pos, null)
	ManagerGrid.set_grid_walkablity(target_grid_pos, false)
	ManagerGrid.set_grid_occupant(target_grid_pos, unit)
	return


func get_ability_grids(unit_grid: Vector2i = unit.grid_pos) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var max_width: int = 1
	var max_height: int = 5
	for i: int in range(-max_width, max_width + 1):
		for j: int in range(-max_height, max_height + 1):
			if j == 0:
				continue
			var potential_grid: Vector2i = unit_grid + Vector2i(i, j)
			if not ManagerGrid.is_grid_walkable(potential_grid):
				continue
			if ManagerGrid.is_grid_occupied(potential_grid):
				continue
			results.append(potential_grid)
	return results
