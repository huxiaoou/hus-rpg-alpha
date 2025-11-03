extends Node

class_name AbilityBase

@export var ability_id: String = ""
@export var ability_name: String = ""
@export var ability_description: String = ""
@export var texture_normal: Texture2D
@export var texture_hover: Texture2D
@export var texture_press: Texture2D

var unit: UnitTest
var is_active: bool = false
var on_ability_finished: Callable


func _ready() -> void:
	is_active = false
	unit = self.owner


func start(_targe_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	is_active = true
	on_ability_finished = _on_ablility_finished
	print("Begin to cast ablility %s" % ability_name)
	return


func finish() -> void:
	is_active = false
	on_ability_finished.call()
	print("Finish ablility %s" % ability_name)
	return
