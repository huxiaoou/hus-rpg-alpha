extends Projectile

class_name Fireball

var damage_radius: int = 1


func deal_damage() -> void:
	for i: int in range(-damage_radius, damage_radius + 1):
		for j: int in range(-damage_radius, damage_radius + 1):
			var potential_grid: Vector2i = target_grid_pos + Vector2i(i, j)
			var occupiant: UnitTest = ManagerGrid.get_grid_occupant(potential_grid)
			if occupiant and occupiant.is_enemy != unit.is_enemy:
				occupiant.take_damage(damage)
		return
