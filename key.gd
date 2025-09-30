extends Node2D

var picked = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not picked:
		picked = true
		Info.key = true
		hide()
		$AudioStreamPlayer.play()


func _on_player_reset() -> void:
	picked = false
	show()


func _on_door_open() -> void:
	queue_free()
