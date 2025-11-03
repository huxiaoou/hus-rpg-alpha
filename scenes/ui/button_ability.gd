extends TextureButton

class_name ButtonAbility

var ability: AbilityBase = null

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


func set_up(ability: AbilityBase) -> void:
	self.ability = ability
	label_description.text = "%s\n%s" % [ability.ability_name, ability.ability_description]
	texture_normal = ability.texture_normal
	texture_hover = ability.texture_hover
	texture_pressed = ability.texture_press
