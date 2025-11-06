extends Node

@onready var camera_control: CameraControl = $CameraControl
@onready var unit_test: UnitTest = $UnitTest


func _ready() -> void:
	unit_test.unit_double_clicked.connect(camera_control.on_unit_double_clicked)
	unit_test.unit_double_clicked.emit(unit_test)
