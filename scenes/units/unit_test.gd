extends CharacterBody2D

class_name UnitTest

@export var start_grid: Vector2i
@export var double_click_threshold_milliseconds: int = 500
@onready var director_abilities: DirectorAbilities = $DirectorAbilities
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal unit_double_clicked(unit: UnitTest)

var grid_pos: Vector2i:
	get:
		return ManagerGrid.get_grid_pos(global_position)
var last_click_time: int = 0


func _ready() -> void:
	global_position = ManagerGrid.get_world_pos(start_grid)
	ManagerUiSignals.ability_selected.connect(director_abilities.set_selected_ability)
	director_abilities.set_selected_ability(director_abilities.get_ability("ability_move"))


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var this_click_time: int = Time.get_ticks_msec()
			if this_click_time - last_click_time < double_click_threshold_milliseconds:
				unit_double_clicked.emit(self)
			last_click_time = this_click_time
