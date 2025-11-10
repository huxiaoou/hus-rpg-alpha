extends Node

class_name StateMachine

@export var starting_state: StateBase

var states: Dictionary[String, StateBase]
var curr_state: StateBase
var is_launched: bool = false


func _ready() -> void:
	for state: StateBase in get_children():
		states[state.state_name] = state
		state.state_changed.connect(on_state_changed)


func launch() -> void:
	is_launched = true
	curr_state = starting_state
	curr_state.enter()
	return


func _process(delta: float) -> void:
	if is_launched:
		curr_state.process(delta)
	return


func _physics_process(delta: float) -> void:
	if is_launched:
		curr_state.physics_process(delta)
	return


func on_state_changed(state_name: String) -> void:
	var new_state: StateBase = states.get(state_name)
	if new_state == null:
		return
	curr_state.exit()
	curr_state = new_state
	curr_state.enter()
	return
