extends AbilityBase

class_name AbilitySword

func start(targe_grid_pos: Vector2i, _on_ablility_finished: Callable) -> void:
	super.start(targe_grid_pos, _on_ablility_finished)
	finish()
	return
