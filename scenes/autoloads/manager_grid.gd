extends Node

var layer_nav: LayerNav


func get_grid_pos(world_pos: Vector2) -> Vector2i:
	return layer_nav.local_to_map(layer_nav.to_local(world_pos))


func get_world_pos(grid_pos: Vector2i) -> Vector2:
	return layer_nav.to_global(layer_nav.map_to_local(grid_pos))


func get_mouse_grid_pos() -> Vector2i:
	return get_grid_pos(layer_nav.get_global_mouse_position())

# --- path finding


func get_nav_grid_path(start_grid_pos: Vector2i, end_grid_pos: Vector2i) -> Array[Vector2i]:
	return layer_nav.get_nav_grid_path(start_grid_pos, end_grid_pos)


func get_nav_world_path(start_grid_pos: Vector2i, end_grid_pos: Vector2i) -> Array[Vector2]:
	var grid_path: Array[Vector2i] = get_nav_grid_path(start_grid_pos, end_grid_pos)
	var world_path: Array[Vector2]
	for grid_pos in grid_path:
		world_path.append(ManagerGrid.get_world_pos(grid_pos))
	return world_path


func get_grid_path_length(grid_path: Array[Vector2i]) -> float:
	if grid_path.size() <= 1:
		return 0
	var length: float = 0
	for i in range(1, grid_path.size()):
		if grid_path[i - 1].x != grid_path[i].x and grid_path[i - 1].y != grid_path[i].y:
			length += sqrt(2)
		else:
			length += 1
	return length


func is_on_ladder(grid_pos: Vector2i) -> bool:
	return layer_nav.is_on_ladder(grid_pos)


# --- manage grid
func is_valid_grid(grid_pos: Vector2i) -> bool:
	return layer_nav.datasets_grid.has(grid_pos)


func is_grid_walkable(grid_pos: Vector2i) -> bool:
	return is_valid_grid(grid_pos) and layer_nav.is_grid_walkable(grid_pos)


func set_grid_walkablity(grid_pos: Vector2i, walkablity: bool) -> void:
	if not is_valid_grid(grid_pos):
		return
	layer_nav.set_grid_walkablity(grid_pos, walkablity)
	return


func is_grid_occupied(grid_pos: Vector2i) -> bool:
	return is_valid_grid(grid_pos) and layer_nav.is_grid_occupied(grid_pos)


func get_grid_occupant(grid_pos: Vector2i) -> UnitTest:
	if not is_valid_grid(grid_pos):
		return null
	return layer_nav.get_grid_occupant(grid_pos)


func set_grid_occupant(grid_pos: Vector2i, unit: UnitTest) -> void:
	if not is_valid_grid(grid_pos):
		return
	layer_nav.set_grid_occupant(grid_pos, unit)
	return


func is_obstacle(grid_pos: Vector2i) -> bool:
	if is_grid_occupied(grid_pos):
		return false
	return not is_grid_walkable(grid_pos)


func is_occupied_by_ally(grid_pos: Vector2i, unit: UnitTest) -> bool:
	if not is_grid_occupied(grid_pos):
		return false
	return get_grid_occupant(grid_pos).is_enemy == unit.is_enemy


func hit_obstacle(start_grid: Vector2i, end_grid: Vector2i) -> bool:
	var start_pos_world: Vector2 = get_world_pos(start_grid)
	var end_pos_world: Vector2 = get_world_pos(end_grid)
	var query_pars: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(start_pos_world, end_pos_world, 2)
	var result: Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_pars)
	return not result.is_empty()
