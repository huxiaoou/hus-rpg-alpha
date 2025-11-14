extends Node

var units_player: Array[UnitTest]
var units_enemy: Array[UnitTest]

signal unit_selected(unit: UnitTest)

var selected_unit: UnitTest
var ability_is_selected: bool = false


func register(unit: UnitTest) -> void:
	if unit.is_enemy:
		units_enemy.append(unit)
	else:
		units_player.append(unit)


func set_selected_unit(unit: UnitTest) -> void:
	if unit.director_abilities.is_performing:
		return
	if unit.is_enemy:
		return
	if selected_unit == unit:
		selected_unit.director_abilities.set_selected_ability(
			selected_unit.director_abilities.get_ability("ability_move"),
		)
		return
	selected_unit = unit
	print("%s selected" % selected_unit.name)
	selected_unit.director_abilities.set_selected_ability(
		selected_unit.director_abilities.get_ability("ability_move"),
	)
	unit_selected.emit(selected_unit)


func set_ability_selected() -> void:
	ability_is_selected = true


func set_ability_unselected() -> void:
	ability_is_selected = false
