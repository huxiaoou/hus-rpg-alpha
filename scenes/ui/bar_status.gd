extends ProgressBar

class_name BarStatus

@export var color: Color
@onready var label: Label = $Label


func _ready() -> void:
	var sb: StyleBoxFlat = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color = color
	sb.border_width_top = 2
	sb.border_width_bottom = 2
	sb.border_width_left = 2
	sb.border_color = Color("cccccc")


func update(new_value: float) -> void:
	value = new_value
	label.text = "%d/%d" % [value, max_value]
