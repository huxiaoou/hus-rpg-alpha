class_name DataGrid

var walkable: bool = true
var occupiant: UnitTest = null
var is_occupied_by_unit: bool:
	get:
		return occupiant != null
	set(value):
		is_occupied_by_unit = true
