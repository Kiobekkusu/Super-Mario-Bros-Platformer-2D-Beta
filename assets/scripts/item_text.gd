extends CanvasLayer

class_name TextPoint

@export var move_amount := 10.0
@export var move_speed := 0.1
var position = Vector2(self.x, self.y)

func TweenText():
	var tween = create_tween()
	tween.tween_property(self, "position:y", position - move_amount, move_speed)
	tween.connect("finished", Callable(self, "on_tween_complete"))

func on_tween_complete():
	pass
