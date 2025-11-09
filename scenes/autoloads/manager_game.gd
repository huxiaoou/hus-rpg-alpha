extends Node

var units_player: Array[UnitTest]
var units_enemy: Array[UnitTest]

signal unit_selected(unit: UnitTest)

var _unit_selected: UnitTest


func register(unit: UnitTest) -> void:
	if unit.is_enemy:
		units_enemy.append(unit)
	else:
		units_player.append(unit)


func set_selected_unit(unit: UnitTest) -> void:
	if unit.director_abilities.is_performing:
		return
	if _unit_selected == unit:
		return
	_unit_selected = unit
	print("%s selected" % _unit_selected.name)
	_unit_selected.director_abilities.set_selected_ability(
		_unit_selected.director_abilities.get_ability("ability_move"),
	)
	unit_selected.emit(_unit_selected)
