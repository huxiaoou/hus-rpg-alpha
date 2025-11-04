extends Node

class_name DirectorAbilities

var is_performing: bool = false
var ability_selected: AbilityBase = null
var abilities: Dictionary[String, AbilityBase] = { }


func _ready() -> void:
	for ablility: AbilityBase in get_children():
		if ablility is AbilityBase:
			abilities[ablility.ability_id] = ablility


func get_ability(ability_id: String) -> AbilityBase:
	return abilities.get(ability_id)


func on_ability_finished() -> void:
	ability_selected.unit.animated_sprite_2d.play("idle")
	is_performing = false


func set_selected_ability(ability: AbilityBase) -> void:
	if is_performing:
		return
	if ability_selected == ability:
		return

	print("Select %s" % ability.ability_name)
	ability_selected = ability


func try_performing_selected_ability() -> void:
	if is_performing:
		print("Is performing %s" % ability_selected.ability_name)
		return
	if ability_selected == null:
		return
	var target_grid_pos: Vector2i = ManagerGrid.get_mouse_grid_pos()
	is_performing = true
	ability_selected.start(target_grid_pos, on_ability_finished)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):
		try_performing_selected_ability()
