extends CharacterBody2D

class_name UnitTest

@export var start_grid: Vector2i
@export var is_enemy: bool = false
@export var potrait: Texture

@export var max_health: int = 100
@export var max_stamina: int = 100
@export var max_magicka: int = 100
@export var max_resolve: int = 100

@onready var director_abilities: DirectorAbilities = $DirectorAbilities
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_unit: CollisionShapeUnit = $CollisionShapeUnit
@onready var slot_weapon: Node2D = $AnimatedSprite2D/SlotWeapon
@onready var bar_health: BarStatus = $AnimatedSprite2D/BarHealth

var cur_health: int
var cur_stamina: int
var cur_magicka: int
var cur_resolve: int

signal unit_double_clicked(unit: UnitTest)
signal unit_selected(unit: UnitTest)
signal unit_damaged(unit: UnitTest)
signal health_changed(new_health: float)
signal magicka_changed(new_health: float)
signal stamina_changed(new_health: float)
signal resolve_changed(new_health: float)

var grid_pos: Vector2i:
	get:
		return ManagerGrid.get_grid_pos(global_position)


func _ready() -> void:
	unit_selected.connect(on_unit_selected)
	collision_shape_unit.single_clicked.connect(on_shape_single_clicked)
	collision_shape_unit.double_clicked.connect(on_shape_double_clicked)
	ManagerUiSignals.ability_selected.connect(director_abilities.set_selected_ability)
	ManagerGame.register(self)
	ManagerTurn.turn_player_entered.connect(on_turn_player_entered)
	ManagerTurn.turn_enemy_entered.connect(on_turn_enemy_entered)
	global_position = ManagerGrid.get_world_pos(start_grid)

	cur_health = max_health
	cur_stamina = max_stamina
	cur_magicka = max_magicka
	cur_resolve = max_resolve
	bar_health.update_max_val(max_health)
	bar_health.update_val(cur_health)


func on_turn_player_entered() -> void:
	if not is_enemy:
		cur_stamina = max_stamina


func on_turn_enemy_entered() -> void:
	if is_enemy:
		cur_stamina = max_stamina


func on_shape_single_clicked() -> void:
	if not ManagerGame.ability_is_selected:
		unit_selected.emit(self)


func on_shape_double_clicked() -> void:
	if not ManagerGame.ability_is_selected:
		unit_double_clicked.emit(self)


func on_unit_selected(unit: UnitTest) -> void:
	ManagerGame.set_selected_unit(unit)


func take_damage(damage: int) -> void:
	print("%s take %d damage" % [name, damage])
	cur_health -= damage
	unit_damaged.emit(damage)
	health_changed.emit(cur_health)
	bar_health.update_val(cur_health)
