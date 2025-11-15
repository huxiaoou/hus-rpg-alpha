extends Node2D

class_name Projectile

@export var damage: int = 4
@export var speed: int = 700

var finish_ability: Callable
var unit: UnitTest
var target_grid_pos: Vector2i
var target_world_pos: Vector2


func setup(finish_ability: Callable, unit: UnitTest, target_grid_pos: Vector2i) -> void:
	self.finish_ability = finish_ability
	self.unit = unit
	self.target_grid_pos = target_grid_pos
	self.target_world_pos = ManagerGrid.get_world_pos(target_grid_pos)
	look_at(target_world_pos)
	return


func deal_damage() -> void:
	var target: UnitTest = ManagerGrid.get_grid_occupant(target_grid_pos)
	if target and target.is_enemy != unit.is_enemy:
		target.take_damage(damage)


func _process(delta: float) -> void:
	global_position = global_position.move_toward(target_world_pos, speed * delta)
	if global_position == target_world_pos:
		deal_damage()
		finish_ability.call()
		queue_free()
