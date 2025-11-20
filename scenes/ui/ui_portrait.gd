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
		player.stamina_changed.connect(on_staminc_changed)
		player.resolve_changed.connect(on_resolve_changed)

		bar_health.max_value = player.max_health
		bar_magicka.max_value = player.max_magicka
		bar_stamina.max_value = player.max_stamina
		bar_resolve.max_value = player.max_resolve

		bar_health.update(player.cur_health)
		bar_magicka.update(player.cur_magicka)
		bar_stamina.update(player.cur_stamina)
		bar_resolve.update(player.cur_resolve)
		texture_rect.texture = player.potrait


func on_health_changed(new_health: float) -> void:
	bar_health.update(new_health)


func on_magicka_changed(new_magicka: float) -> void:
	bar_magicka.update(new_magicka)


func on_staminc_changed(new_stamina: float) -> void:
	bar_stamina.update(new_stamina)


func on_resolve_changed(new_resolve: float) -> void:
	bar_resolve.update(new_resolve)
