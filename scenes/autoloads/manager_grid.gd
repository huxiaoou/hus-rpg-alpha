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
