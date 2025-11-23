extends HBoxContainer

class_name UIPortrait

var double_click_threshold_milliseconds: int = 500
var last_click_time: int = 0

@onready var bar_health: BarStatus = $MarginContainer/VBoxContainer/BarHealth
@onready var bar_magicka: BarStatus = $MarginContainer/VBoxContainer/BarMagicka
@onready var bar_stamina: BarStatus = $MarginContainer/VBoxContainer/BarStamina
@onready var bar_resolve: BarStatus = $MarginContainer/VBoxContainer/BarResolve
@onready var texture_btn: TextureButton = $Panel/TextureBtn

var player: UnitTest = null:
	set(new_player):
		player = new_player
		player.health_changed.connect(on_health_changed)
		player.magicka_changed.connect(on_magicka_changed)
		player.stamina_changed.connect(on_stamina_changed)
		player.resolve_changed.connect(on_resolve_changed)

		bar_health.update_max_val(player.max_health)
		bar_magicka.update_max_val(player.max_magicka)
		bar_stamina.update_max_val(player.max_stamina)
		bar_resolve.update_max_val(player.max_resolve)

		bar_health.update_val(player.cur_health)
		bar_magicka.update_val(player.cur_magicka)
		bar_stamina.update_val(player.cur_stamina)
		bar_resolve.update_val(player.cur_resolve)
		texture_btn.texture_normal = player.potrait
		texture_btn.pressed.connect(on_portrait_pressed)


func on_portrait_pressed() -> void:
	print("%s is selected" % player.name)
	var this_click_time: int = Time.get_ticks_msec()
	if this_click_time - last_click_time < double_click_threshold_milliseconds:
		on_portrait_double_clicked()
	else:
		on_portrait_single_clicked()
	last_click_time = this_click_time


func on_portrait_single_clicked() -> void:
	if not ManagerGame.ability_is_selected:
		player.unit_selected.emit(player)
	return


func on_portrait_double_clicked() -> void:
	print("double clicked")
	player.unit_double_clicked.emit(player)
	return


func on_health_changed(new_health: float) -> void:
	bar_health.update_val(new_health)


func on_magicka_changed(new_magicka: float) -> void:
	bar_magicka.update_val(new_magicka)


func on_stamina_changed(new_stamina: float) -> void:
	bar_stamina.update_val(new_stamina)


func on_resolve_changed(new_resolve: float) -> void:
	bar_resolve.update_val(new_resolve)
