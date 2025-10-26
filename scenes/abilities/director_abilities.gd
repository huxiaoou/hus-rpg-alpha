extends Node

class_name DirectorAbilities

var is_performing: bool = false
var performing_ability: AbilityBase = null
var abilities: Dictionary[String, AbilityBase] = { }


func _ready() -> void:
	for ablility: AbilityBase in get_children():
		if ablility is AbilityBase:
			abilities[ablility.ability_id] = ablility


func get_ability(ability_id: String) -> AbilityBase:
	return abilities.get(ability_id)


func set_performing_ability(ability: AbilityBase) -> void:
	performing_ability = ability
	is_performing = true


func on_ability_finished() -> void:
	is_performing = false
