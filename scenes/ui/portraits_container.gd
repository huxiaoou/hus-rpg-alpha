extends VBoxContainer

class_name PortraitsContainer

@export var scene_portrait: PackedScene


func register(player: UnitTest) -> void:
	var ui_portrait: UIPortrait = scene_portrait.instantiate()
	self.add_child(ui_portrait)
	ui_portrait.player = player
	return
