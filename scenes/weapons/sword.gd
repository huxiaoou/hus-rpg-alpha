extends Node2D

class_name Sword

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var finish_ability: Callable
var unit: UnitTest
var damage: int = 5
var target: UnitTest


func setup(finish_ability: Callable, unit: UnitTest, target_grid_pos: Vector2i) -> void:
	self.finish_ability = finish_ability
	self.unit = unit
	self.target = ManagerGrid.get_grid_occupant(target_grid_pos)
	if target_grid_pos.y > unit.grid_pos.y:
		rotation_degrees = 90
	elif target_grid_pos.y < unit.grid_pos.y:
		rotation_degrees = 270
	else:
		rotation_degrees = 0
	animation_player.play("attack")


func deal_damage() -> void:
	if target and target.is_enemy != unit.is_enemy:
		target.take_damage(damage)


func animation_finished() -> void:
	finish_ability.call()
	queue_free()
