extends StateBase

var listen_for_input: bool = false
#var go_to_turn_enemy: bool = false


func enter() -> void:
	super.enter()
	listen_for_input = true
	#go_to_turn_enemy = false
	ManagerTurn.turn_enemy_started.connect(on_turn_enemy_started)
	return


func exit() -> void:
	super.exit()
	listen_for_input = false
	ManagerTurn.turn_enemy_started.disconnect(on_turn_enemy_started)
	return

#func process(_delta: float) -> void:
#if go_to_turn_enemy:
#state_changed.emit("StateTurnEnemy")
#return
#


func on_turn_enemy_started() -> void:
	if ManagerGame.selected_unit.director_abilities.is_performing:
		return
	state_changed.emit("StateTurnEnemy")
	return


func _unhandled_input(event: InputEvent) -> void:
	if not listen_for_input:
		return
	if event.is_action_pressed("left_mouse_click"):
		ManagerGame.selected_unit.director_abilities.try_performing_selected_ability()
	elif event.is_action_pressed("right_mouse_click"):
		ManagerGame.selected_unit.director_abilities.unselect_ability()
	return
