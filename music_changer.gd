extends Node2D

@export var track : int

signal change
signal dark

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Info.track = track
		emit_signal("change")
		
		if track == 2:
			emit_signal("dark")
