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
	if ManagerGrid.is_on_ladder(ability_selected.unit.grid_pos):
		ability_selected.unit.animated_sprite_2d.play("idle_on_ladder")
	else:
		ability_selected.unit.animated_sprite_2d.play("idle")
	is_performing = false


func set_selected_ability(ability: AbilityBase) -> void:
	if is_performing:
		return
	if ability_selected == ability:
		return

	print("Select ability %s" % ability.ability_name)
	ability_selected = ability
	ManagerGrid.visualize_grid(ability_selected.get_ability_grids())
	ManagerGame.set_ability_selected()


func unselect_ability() -> void:
	ability_selected = null
	ManagerGrid.layer_vis.clear()
	ManagerGame.set_ability_unselected()


func try_performing_selected_ability() -> void:
	if ability_selected == null:
		return
	if is_performing:
		print("Is performing %s" % ability_selected.ability_name)
		return
	if ManagerGame.selected_unit != ability_selected.unit:
		return
	var target_grid_pos: Vector2i = ManagerGrid.get_mouse_grid_pos()
	if target_grid_pos not in ability_selected.get_ability_grids():
		print("Target grid %s is out of range for %s" % [str(target_grid_pos), ability_selected.ability_name])
		return
	is_performing = true
	ability_selected.start(target_grid_pos, on_ability_finished)
