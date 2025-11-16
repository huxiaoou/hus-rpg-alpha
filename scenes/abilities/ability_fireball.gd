extends AbilityBase

class_name AbilityFireball

@export var scene_fireball: PackedScene


func start(target_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(target_grid_pos, _on_ablility_finished)
	if target_grid_pos.x > unit.grid_pos.x:
		unit.animated_sprite_2d.scale = Vector2(1, 1)
	elif target_grid_pos.x < unit.grid_pos.x:
		unit.animated_sprite_2d.scale = Vector2(-1, 1)

	var fireball: ProjectileFireball = scene_fireball.instantiate()
	get_tree().current_scene.add_child(fireball)
	fireball.global_position = unit.global_position
	fireball.setup(finish, unit, target_grid_pos)
	return


func get_ability_grids(unit_grid: Vector2i = unit.grid_pos) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	var max_range: int = 5
	for i: int in range(-max_range, max_range + 1):
		for j: int in range(-max_range, max_range + 1):
			if i == 0 and j == 0:
				continue
			var potential_grid: Vector2i = unit_grid + Vector2i(i, j)
			if ManagerGrid.is_obstacle(potential_grid):
				continue
			if ManagerGrid.is_occupied_by_ally(potential_grid, unit):
				continue
			if ManagerGrid.hit_obstacle(unit_grid, potential_grid):
				continue
			results.append(potential_grid)
	return results
