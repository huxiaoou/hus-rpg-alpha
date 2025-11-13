extends Node

class_name StateBase

signal state_changed(state_name: String)

@export var state_name: String


func enter() -> void:
	print("Enter %s" % state_name)
	match state_name:
		"StateTurnPlayer":
			ManagerTurn.turn_player_entered.emit()
		"StateTurnEnemy":
			ManagerTurn.turn_enemy_entered.emit()
		_:
			pass
	return


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func exit() -> void:
	print("Exit %s" % state_name)
	return
