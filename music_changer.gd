extends Node2D

@export var track : int

signal change

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Info.track = track
		emit_signal("change")
