extends Node

var layer_nav: LayerNav


func get_grid_pos(world_pos: Vector2) -> Vector2i:
	return layer_nav.local_to_map(layer_nav.to_local(world_pos))


func get_world_pos(grid_pos: Vector2i) -> Vector2:
	return layer_nav.to_global(layer_nav.map_to_local(grid_pos))


func get_mouse_grid_pos() -> Vector2i:
	return get_grid_pos(layer_nav.get_global_mouse_position())
