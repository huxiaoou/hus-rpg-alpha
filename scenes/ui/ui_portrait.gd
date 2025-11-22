extends HBoxContainer

class_name UIPortrait

@onready var bar_health: BarStatus = $MarginContainer/VBoxContainer/BarHealth
@onready var bar_magicka: BarStatus = $MarginContainer/VBoxContainer/BarMagicka
@onready var bar_stamina: BarStatus = $MarginContainer/VBoxContainer/BarStamina
@onready var bar_resolve: BarStatus = $MarginContainer/VBoxContainer/BarResolve
@onready var texture_rect: TextureRect = $Panel/TextureRect

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
		texture_rect.texture = player.potrait


func on_health_changed(new_health: float) -> void:
	bar_health.update_val(new_health)


func on_magicka_changed(new_magicka: float) -> void:
	bar_magicka.update_val(new_magicka)


func on_stamina_changed(new_stamina: float) -> void:
	bar_stamina.update_val(new_stamina)


func on_resolve_changed(new_resolve: float) -> void:
	bar_resolve.update_val(new_resolve)
