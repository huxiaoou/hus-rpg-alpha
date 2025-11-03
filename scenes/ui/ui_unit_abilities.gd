extends HBoxContainer

class_name UIUnitAbilities

@export var ui_button_ability_scene: PackedScene


func _ready() -> void:
	call_deferred("update_ui_unit_ability")


func update_ui_unit_ability() -> void:
	var director_abilities: DirectorAbilities = get_tree().current_scene.get_node("UnitTest").get_node("DirectorAbilities")
	for node in self.get_children():
		node.queue_free()

	for ability_id in director_abilities.abilities.keys():
		var ability: AbilityBase = director_abilities.abilities[ability_id]
		var button: ButtonAbility = ui_button_ability_scene.instantiate()
		self.add_child(button)
		button.set_up(ability)
