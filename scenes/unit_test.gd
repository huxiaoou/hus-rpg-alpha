extends CharacterBody2D

class_name UnitTest

var speed: float = 100
var direction_move: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	direction_move = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction_move * speed * delta
	move_and_slide()
