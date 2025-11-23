extends Node

class_name EnemyAI

var enemy: UnitTest = null


func _ready() -> void:
	enemy = get_parent()


func think() -> AIAbilityData:
	return null


func try_perform_move(attack_ability: AbilityBase, ai_ability_data: AIAbilityData) -> bool:
	if attack_ability == null:
		return false
	var ability_move: AbilityBase = enemy.director_abilities.get_ability("ability_move")
	if ability_move == null:
		return false
	if enemy.cur_stamina < ability_move.stamina_cost:
		return false

	var targets_number: int = 0
	var target_grid: Vector2i
	for grid in ability_move.get_ability_grids():
		var targets: Array[UnitTest] = get_targets_in_grids(attack_ability.get_ability_grids(grid))
		if targets.size() > targets_number:
			targets_number = targets.size()
			target_grid = grid
	if targets_number == 0:
		return false
	enemy.director_abilities.ability_selected = ability_move
	ai_ability_data.ability = ability_move
	ai_ability_data.grid = target_grid
	return true


func try_perform_attack(attack_ability: AbilityBase, ai_ability_data: AIAbilityData) -> bool:
	if attack_ability == null:
		return false
	if enemy.cur_stamina < attack_ability.stamina_cost:
		return false
	var targets: Array[UnitTest] = get_targets_in_grids(attack_ability.get_ability_grids())
	if targets.is_empty():
		return false

	var target: UnitTest = targets.pick_random()
	enemy.director_abilities.ability_selected = attack_ability
	ai_ability_data.ability = attack_ability
	ai_ability_data.grid = target.grid_pos
	return true


func get_targets_in_grids(grids: Array[Vector2i]) -> Array[UnitTest]:
	var targets: Array[UnitTest] = []
	for grid in grids:
		if ManagerGrid.is_grid_occupied(grid):
			var t: UnitTest = ManagerGrid.get_grid_occupant(grid)
			if not t.is_enemy:
				targets.append(t)
	return targets
