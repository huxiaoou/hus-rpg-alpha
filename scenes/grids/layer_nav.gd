extends TileMapLayer

class_name LayerNav

var a_star: AStarGrid2D
var datasets_grid: Dictionary[Vector2i, DataGrid] = { }


func _ready() -> void:
	ManagerGrid.layer_nav = self
	initialize()


func initialize() -> void:
	a_star = AStarGrid2D.new()
	a_star.region = get_used_rect()
	a_star.cell_size = tile_set.tile_size
	a_star.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	a_star.update()

	var used_cells: Array[Vector2i] = get_used_cells()
	for cell in used_cells:
		datasets_grid[cell] = DataGrid.new()
		if not get_cell_tile_data(cell).get_custom_data("walkable"):
			a_star.set_point_solid(cell)
			datasets_grid[cell].walkable = false


func is_grid_walkable(grid_pos: Vector2i) -> bool:
	return datasets_grid[grid_pos].walkable


func is_on_ladder(grid_pos: Vector2i) -> bool:
	var not_walkable_on_horizontal: bool = not (is_grid_walkable(grid_pos + Vector2i(1, 0)) or is_grid_walkable(grid_pos + Vector2i(-1, 0)))
	var walkable_on_vertical: bool = is_grid_walkable(grid_pos + Vector2i(0, 1)) and is_grid_walkable(grid_pos + Vector2i(0, -1))
	return not_walkable_on_horizontal and walkable_on_vertical


func set_grid_walkablity(grid_pos: Vector2i, walkablity: bool) -> void:
	datasets_grid[grid_pos].walkable = walkablity
	a_star.set_point_solid(grid_pos, !walkablity)
	return


func is_grid_occupied(grid_pos: Vector2i) -> bool:
	return datasets_grid[grid_pos].is_occupied_by_unit


func get_grid_occupant(grid_pos: Vector2i) -> UnitTest:
	return datasets_grid[grid_pos].occupiant


func set_grid_occupant(grid_pos: Vector2i, unit: UnitTest) -> void:
	datasets_grid[grid_pos].occupiant = unit
	return


func get_nav_grid_path(start_grid_pos: Vector2i, end_grid_pos: Vector2i) -> Array[Vector2i]:
	if not a_star.is_in_boundsv(end_grid_pos):
		#print("Destination %s is unreachable" % end_grid_pos)
		return []
	var path: Array[Vector2i] = a_star.get_id_path(start_grid_pos, end_grid_pos, true)
	#if not path.is_empty() and path[-1] != end_grid_pos:
	#print("No directive path available for %s" % end_grid_pos)
	return path
