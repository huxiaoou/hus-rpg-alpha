extends TextureButton

class_name ButtonAbility

@export var description: String = "Give description for the ability here."
@onready var label_description: Label = $LabelDescription


func _ready() -> void:
	label_description.visible = false
	label_description.text = description
	return


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		label_description.visible = !label_description.visible


func _on_mouse_exited() -> void:
	label_description.visible = false
