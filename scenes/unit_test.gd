extends CharacterBody2D

class_name UnitTest

var speed: float = 500
var direction_move: Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	direction_move = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	if direction_move.x > 0:
		direction_move = Vector2.RIGHT
	elif direction_move.x < 0:
		direction_move = Vector2.LEFT
	else:
		direction_move = Vector2.ZERO
	velocity = direction_move * speed
	move_and_slide()
