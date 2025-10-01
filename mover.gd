extends Node2D


func _on_player_reset() -> void:
	$AnimationPlayer.play("RESET")
	await get_tree().create_timer(0.05).timeout
	$AnimationPlayer.play("new_animation")
