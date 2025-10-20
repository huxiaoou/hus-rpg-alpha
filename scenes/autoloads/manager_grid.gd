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
