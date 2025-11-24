extends Node

@onready var camera_control: CameraControl = $CameraControl
@onready var state_machine: StateMachine = $StateMachine
@onready var ui: UI = $UI


func _ready() -> void:
	for unit: UnitTest in ManagerGame.units_player:
		unit.unit_double_clicked.connect(camera_control.on_unit_double_clicked)
		ManagerGrid.set_grid_walkablity(unit.grid_pos, false)
		ManagerGrid.set_grid_occupant(unit.grid_pos, unit)
		ui.portraits_container.register(unit)
		unit.unit_damaged.connect(camera_control.on_unit_hit)

	for unit: UnitTest in ManagerGame.units_enemy:
		unit.unit_double_clicked.connect(camera_control.on_unit_double_clicked)
		ManagerGrid.set_grid_walkablity(unit.grid_pos, false)
		ManagerGrid.set_grid_occupant(unit.grid_pos, unit)
		unit.unit_damaged.connect(camera_control.on_unit_hit)

	if not ManagerGame.units_player.is_empty():
		var unit: UnitTest = ManagerGame.units_player[0]
		print("%s is picked as default" % unit.name)
		ManagerGame.set_selected_unit(unit)
		unit.unit_double_clicked.emit(unit)

	state_machine.launch()
