extends Node

class_name AbilityBase

@export var ability_id: String = ""
@export var ability_name: String = ""
@export var ability_description: String = ""
@export var texture_normal: Texture2D
@export var texture_hover: Texture2D
@export var texture_press: Texture2D
@export var stamina_cost: int = 80

var unit: UnitTest
var is_active: bool = false
var on_ability_finished: Callable


func _ready() -> void:
	is_active = false
	unit = self.owner


func start(_targe_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	unit.z_index = 1
	is_active = true
	on_ability_finished = _on_ablility_finished
	unit.cur_stamina -= stamina_cost
	unit.stamina_changed.emit(unit.cur_stamina)
	print("Begin to cast ablility %s" % ability_name)
	return


func finish() -> void:
	is_active = false
	on_ability_finished.call()
	unit.z_index = 0
	print("Finish ablility %s" % ability_name)
	return


func get_ability_grids(_unit_grid: Vector2i = unit.grid_pos) -> Array[Vector2i]:
	return []
