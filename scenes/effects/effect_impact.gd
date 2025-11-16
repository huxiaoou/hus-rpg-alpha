extends Node2D

class_name EffectImpact

signal effect_finished()

@export var effect_name: String
@export var effect_audio: AudioStream
@export var duration_milliseconds: int = 1000

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var bgn_time: int


func _ready() -> void:
	animated_sprite_2d.animation = effect_name
	audio_stream_player_2d.stream = effect_audio
	bgn_time = Time.get_ticks_msec()
	animated_sprite_2d.play(effect_name)
	audio_stream_player_2d.play()


func _process(delta: float) -> void:
	var cur_time: int = Time.get_ticks_msec()
	if cur_time >= bgn_time + duration_milliseconds:
		effect_finished.emit()
		queue_free()
