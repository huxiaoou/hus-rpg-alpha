extends AbilityBase

class_name AbilityShoot

@export var scene_arrow: PackedScene


func start(target_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(target_grid_pos, _on_ablility_finished)
	if target_grid_pos.x > unit.grid_pos.x:
		unit.animated_sprite_2d.scale = Vector2(1, 1)
	elif target_grid_pos.x < unit.grid_pos.x:
		unit.animated_sprite_2d.scale = Vector2(-1, 1)

	var arrow: Projectile = scene_arrow.instantiate()
	get_tree().current_scene.add_child(arrow)
	arrow.global_position = unit.global_position
	arrow.setup(finish, unit, target_grid_pos)
	return


func get_ability_grids(unit_grid: Vector2i = unit.grid_pos) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var max_range: int = 5
	for i: int in range(-max_range, max_range + 1):
		if i == 0:
			continue
		var potential_grid: Vector2i = unit_grid + Vector2i(i, 0)
		if is_valid_ability_grid(potential_grid, unit_grid):
			results.append(potential_grid)

		potential_grid = unit_grid + Vector2i(0, i)
		if is_valid_ability_grid(potential_grid, unit_grid):
			results.append(potential_grid)
	return results


func is_valid_ability_grid(grid_pos: Vector2i, unit_grid: Vector2i) -> bool:
	if ManagerGrid.is_obstacle(grid_pos):
		return false
	if ManagerGrid.is_occupied_by_ally(grid_pos, unit):
		return false
	if ManagerGrid.hit_obstacle(unit_grid, grid_pos):
		return false
	return true
