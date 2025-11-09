extends HBoxContainer

class_name UIUnitAbilities

@export var ui_button_ability_scene: PackedScene

var selected_unit: UnitTest = null


func _ready() -> void:
	ManagerGame.unit_selected.connect(on_unit_selected)


func on_unit_selected(unit: UnitTest) -> void:
	if selected_unit == unit:
		return
	else:
		selected_unit = unit
	update_ui_unit_ability()
	return


func update_ui_unit_ability() -> void:
	var director_abilities: DirectorAbilities = selected_unit.director_abilities
	for node in self.get_children():
		node.queue_free()
	for ability_id in director_abilities.abilities.keys():
		var ability: AbilityBase = director_abilities.abilities[ability_id]
		var button: ButtonAbility = ui_button_ability_scene.instantiate()
		self.add_child(button)
		button.set_up(ability)
