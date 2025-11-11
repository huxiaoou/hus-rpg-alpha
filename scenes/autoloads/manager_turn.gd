extends Node

signal turn_player_started()
signal turn_enemy_started()


func start_turn_player() -> void:
	turn_player_started.emit()
	return


func start_turn_enemy() -> void:
	turn_enemy_started.emit()
	return
