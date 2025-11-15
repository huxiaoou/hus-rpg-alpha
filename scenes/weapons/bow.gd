extends Node2D

class_name Bow

@export var scene_arrow: PackedScene = null

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_shoot: Node2D = $PointShoot

var finish_ability: Callable
var unit: UnitTest
var damage: int = 3
var target_grid_pos: Vector2i


func setup(finish_ability: Callable, unit: UnitTest, target_grid_pos: Vector2i) -> void:
	self.finish_ability = finish_ability
	self.unit = unit
	self.target_grid_pos = target_grid_pos
	if target_grid_pos.y > unit.grid_pos.y:
		rotation_degrees = 90
	elif target_grid_pos.y < unit.grid_pos.y:
		rotation_degrees = 270
	else:
		rotation_degrees = 0
	animation_player.play("shoot")


func shoot() -> void:
	var arrow: Projectile = scene_arrow.instantiate()
	get_tree().current_scene.add_child(arrow)
	arrow.global_position = point_shoot.global_position
	arrow.setup(finish_ability, unit, target_grid_pos)
	return
