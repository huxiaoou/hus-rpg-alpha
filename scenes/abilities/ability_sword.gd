extends AbilityBase

class_name AbilitySword

@export var scene_sword: PackedScene = null


func start(target_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(target_grid_pos, _on_ablility_finished)
	if target_grid_pos.x > unit.grid_pos.x:
		unit.animated_sprite_2d.scale.x = 1
	elif target_grid_pos.x < unit.grid_pos.x:
		unit.animated_sprite_2d.scale.x = -1
	var sword: Sword = scene_sword.instantiate()
	unit.slot_weapon.position = (target_grid_pos - unit.grid_pos) * ManagerGrid.tile_size * unit.animated_sprite_2d.scale.x
	unit.slot_weapon.add_child(sword)
	sword.setup(finish, unit, target_grid_pos)
	return


func get_ability_grids(unit_grid: Vector2i = unit.grid_pos) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var radius = 1
	for i: int in range(-radius, radius + 1):
		for j: int in range(-radius, radius + 1):
			if i == 0 and j == 0:
				continue
			var potential_grid: Vector2i = unit_grid + Vector2i(i, j)
			if ManagerGrid.is_obstacle(potential_grid):
				continue
			if ManagerGrid.is_occupied_by_ally(potential_grid, unit):
				continue
			results.append(potential_grid)
	return results
