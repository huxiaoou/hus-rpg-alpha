extends Node

signal turn_player_started()
signal turn_enemy_started()
signal turn_player_entered()
signal turn_enemy_entered()


func start_turn_player() -> void:
	turn_player_started.emit()
	return


func start_turn_enemy() -> void:
	turn_enemy_started.emit()
	return
