extends VBoxContainer

@onready var label_turn: Label = $LabelTurn
@onready var button_end_turn: Button = $ButtonEndTurn


func _ready() -> void:
	button_end_turn.pressed.connect(on_turn_end_button_pressed)
	ManagerTurn.turn_player_entered.connect(on_turn_player_started)
	ManagerTurn.turn_enemy_entered.connect(on_turn_enemy_started)
	return


func on_turn_end_button_pressed() -> void:
	ManagerTurn.start_turn_enemy()
	return


func on_turn_player_started() -> void:
	label_turn.text = "Player's Turn"
	return


func on_turn_enemy_started() -> void:
	label_turn.text = "Enemy's Turn"
	return
