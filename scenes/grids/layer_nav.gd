extends TileMapLayer

class_name LayerNav

var a_star: AStarGrid2D


func _ready() -> void:
	ManagerGrid.layer_nav = self
	initialize()


func initialize() -> void:
	a_star = AStarGrid2D.new()
	a_star.region = get_used_rect()
	a_star.cell_size = tile_set.tile_size
	a_star.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	a_star.update()
