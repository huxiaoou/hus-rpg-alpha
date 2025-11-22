extends ProgressBar

class_name BarStatus

@export var color: Color
@onready var label: Label = $Label
@onready var progress_bar_front: ProgressBar = $ProgressBarFront

var styleboxflat_back: StyleBoxFlat = null
var styleboxflat_front: StyleBoxFlat = null


func _ready() -> void:
	styleboxflat_back = get_theme_stylebox("fill")
	styleboxflat_front = StyleBoxFlat.new()
	progress_bar_front.add_theme_stylebox_override("fill", styleboxflat_front)
	styleboxflat_front.bg_color = color
	styleboxflat_front.border_width_left = 2
	styleboxflat_front.border_width_top = 2
	styleboxflat_front.border_width_bottom = 2


func update_max_val(new_max_value: float) -> void:
	progress_bar_front.max_value = new_max_value
	max_value = new_max_value
	update_label()


func update_val(new_value: float) -> void:
	if new_value < progress_bar_front.value:
		progress_bar_front.value = new_value
		await get_tree().create_timer(0.5).timeout
		var tween: Tween = get_tree().create_tween()
		for __ in range(3):
			tween.tween_property(styleboxflat_back, "bg_color", Color(1, 1, 1, 0), 0.1)
			tween.tween_property(styleboxflat_back, "bg_color", Color(1, 1, 1, 1), 0.1)
		tween.tween_property(self, "value", new_value, 0.3)
		tween.tween_callback(update_label)
	elif new_value > progress_bar_front.value:
		value = new_value
		await get_tree().create_timer(0.5).timeout
		var tween: Tween = get_tree().create_tween()
		for __ in range(3):
			tween.tween_property(styleboxflat_back, "bg_color", Color(1, 1, 1, 0), 0.1)
			tween.tween_property(styleboxflat_back, "bg_color", Color(1, 1, 1, 1), 0.1)
		tween.tween_property(progress_bar_front, "value", new_value, 0.3)
		tween.tween_callback(update_label)


func update_label() -> void:
	label.text = "%d/%d" % [value, max_value]
