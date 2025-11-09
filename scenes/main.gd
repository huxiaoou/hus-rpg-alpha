extends Node

@onready var camera_control: CameraControl = $CameraControl


func _ready() -> void:
	for unit: UnitTest in ManagerGame.units_player:
		unit.unit_double_clicked.connect(camera_control.on_unit_double_clicked)

	if not ManagerGame.units_player.is_empty():
		var unit: UnitTest = ManagerGame.units_player[0]
		print("%s is picked as default" % unit.name)
		ManagerGame.set_selected_unit(unit)
		unit.unit_double_clicked.emit(unit)
