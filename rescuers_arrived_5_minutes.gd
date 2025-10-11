extends Sprite2D


func _on_rescue_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AnimationPlayer.play("TooLate")
