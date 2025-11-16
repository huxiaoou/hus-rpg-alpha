extends Node2D

class_name Projectile

@export var damage: int = 4
@export var speed: int = 700
@export var anim_name: String
@export var fire_audio: AudioStream
@export var scene_effect_impact: PackedScene

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var finish_ability: Callable
var unit: UnitTest
var target_grid_pos: Vector2i
var target_world_pos: Vector2


func _ready() -> void:
	animated_sprite_2d.animation = anim_name
	audio_stream_player_2d.stream = fire_audio


func setup(finish_ability: Callable, unit: UnitTest, target_grid_pos: Vector2i) -> void:
	self.finish_ability = finish_ability
	self.unit = unit
	self.target_grid_pos = target_grid_pos
	self.target_world_pos = ManagerGrid.get_world_pos(target_grid_pos)
	audio_stream_player_2d.play()
	look_at(target_world_pos)
	return


func deal_damage() -> void:
	var target: UnitTest = ManagerGrid.get_grid_occupant(target_grid_pos)
	if target and target.is_enemy != unit.is_enemy:
		target.take_damage(damage)


func _process(delta: float) -> void:
	global_position = global_position.move_toward(target_world_pos, speed * delta)
	if global_position == target_world_pos:
		if scene_effect_impact:
			var effect_impact: EffectImpact = scene_effect_impact.instantiate()
			get_tree().current_scene.add_child(effect_impact)
			effect_impact.global_position = global_position
			effect_impact.effect_finished.connect(on_impact_effect_finished)
		else:
			on_impact_effect_finished()
		visible = false
		set_process(false)


func on_impact_effect_finished() -> void:
	deal_damage()
	finish_ability.call()
	queue_free()
