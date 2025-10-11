extends TileMap


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$AnimationPlayer.play("Fade")
		await $AnimationPlayer.animation_finished
		queue_free()
