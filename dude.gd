extends Node2D

var onArea = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Posess") and onArea:
		sacrifice()

func sacrifice():
	Info.posessing = true
	Info.hop = true
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		onArea = false
