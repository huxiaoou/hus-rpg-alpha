extends AbilityBase

class_name AbilityMove

@export var speed: float = 200
var path: Array[Vector2] = []


func move(_target_world_pos: Vector2, delta: float) -> void:
	unit.global_position = unit.global_position.move_toward(_target_world_pos, speed * delta)


func _process(delta: float) -> void:
	if not is_active:
		return

	if path.is_empty():
		finish()
	else:
		if path[0].x > unit.global_position.x:
			unit.animated_sprite_2d.scale.x = 1
		elif path[0].x < unit.global_position.x:
			unit.animated_sprite_2d.scale.x = -1
		if path[0].y != unit.global_position.y:
			if unit.animated_sprite_2d.animation != "climb":
				unit.animated_sprite_2d.play("climb")
		else:
			if unit.animated_sprite_2d.animation == "climb":
				unit.animated_sprite_2d.play("walk")
		move(path[0], delta)
		if unit.global_position == path[0]:
			path.remove_at(0)


func start(targe_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(targe_grid_pos, _on_ablility_finished)
	unit.animated_sprite_2d.play("walk")
	path = ManagerGrid.get_nav_world_path(unit.grid_pos, targe_grid_pos)
	return
