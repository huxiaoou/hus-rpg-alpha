extends StateBase

var go_to_player_turn: bool = false


func enter() -> void:
	super.enter()
	go_to_player_turn = false
	ManagerTurn.turn_player_started.connect(on_turn_player_started)
	return


func exit() -> void:
	super.exit()
	ManagerTurn.turn_player_started.disconnect(on_turn_player_started)
	return


func on_turn_player_started() -> void:
	state_changed.emit("StateTurnPlayer")
	return


func enemies_performs() -> void:
	for enemy in ManagerGame.units_enemy:
		print("check %s" % enemy.name)
		if enemy.director_abilities.try_perform_ai_ability():
			print("%s is performing" % enemy.name)
			return
	ManagerTurn.start_turn_player()
	go_to_player_turn = true
	return


func process(_delta: float) -> void:
	if go_to_player_turn:
		return
	enemies_performs()
