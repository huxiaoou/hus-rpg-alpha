extends CharacterBody2D

class_name UnitTest

@export var start_grid: Vector2i
@export var is_enemy: bool = false

@onready var director_abilities: DirectorAbilities = $DirectorAbilities
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_unit: CollisionShapeUnit = $CollisionShapeUnit

signal unit_double_clicked(unit: UnitTest)
signal unit_selected(unit: UnitTest)

var grid_pos: Vector2i:
	get:
		return ManagerGrid.get_grid_pos(global_position)


func _ready() -> void:
	unit_selected.connect(on_unit_selected)
	collision_shape_unit.single_clicked.connect(on_shape_single_clicked)
	collision_shape_unit.double_clicked.connect(on_shape_double_clicked)
	ManagerUiSignals.ability_selected.connect(director_abilities.set_selected_ability)
	ManagerGame.register(self)
	global_position = ManagerGrid.get_world_pos(start_grid)


func on_shape_single_clicked() -> void:
	if not ManagerGame.ability_is_selected:
		unit_selected.emit(self)


func on_shape_double_clicked() -> void:
	if not ManagerGame.ability_is_selected:
		unit_double_clicked.emit(self)


func on_unit_selected(unit: UnitTest) -> void:
	print("on_unit_selected_triggered")
	ManagerGame.set_selected_unit(unit)
