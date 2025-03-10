extends StaticBody2D

# Registrar la clase Block
class_name Block

# Variables para el movimiento del bloque
var is_moving := false
@export var move_amount := 10.0
@export var move_speed := 0.1

func move_block():
	if not is_moving:
		is_moving = true
		var tween = create_tween()
		tween.tween_property(self, "position:y", position.y - move_amount, move_speed)
		tween.tween_property(self, "position:y", position.y, move_speed)
		tween.connect("finished", Callable(self, "on_tween_complete"))

func on_tween_complete():
	is_moving = false
