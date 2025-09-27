extends Path2D

@export var speed: float = 100.0
var prev_pos
var velocity

func _process(delta):
	$PathFollow2D.progress += speed * delta
