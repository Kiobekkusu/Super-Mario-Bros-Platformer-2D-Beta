extends StaticBody2D

# Registrar la clase Block
class_name BlockCoin

# Variables para el movimiento del bloque
var is_moving := false
@export var move_amount := 10.0
@export var move_speed := 0.1
@onready var anim_block = $Sprite2D/AnimationPlayer
var stroke = false

func _ready():
	anim_block.play("IDLE")

func move_block():
	if not is_moving and stroke != true:
		is_moving = true
		var tween = create_tween()
		anim_block.play("STOP")
		tween.tween_property(self, "position:y", position.y - move_amount, move_speed)
		tween.tween_property(self, "position:y", position.y, move_speed)
		tween.connect("finished", Callable(self, "on_tween_complete"))

func on_tween_complete():
	is_moving = false
	stroke = true
	
