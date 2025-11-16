extends AnimatedSprite2D

class_name EffectImpact

func _ready() -> void:
	animation_finished.connect(queue_free)
