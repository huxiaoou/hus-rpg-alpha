extends StateBase

var listen_for_input: bool = false


func enter() -> void:
	super.enter()
	listen_for_input = true
	return


func exit() -> void:
	super.exit()
	listen_for_input = false
	return


func _unhandled_input(event: InputEvent) -> void:
	if not listen_for_input:
		return
	if event.is_action_pressed("left_mouse_click"):
		ManagerGame.selected_unit.director_abilities.try_performing_selected_ability()
	elif event.is_action_pressed("right_mouse_click"):
		ManagerGame.selected_unit.director_abilities.unselect_ability()
	return
