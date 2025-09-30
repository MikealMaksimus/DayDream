extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not Info.onCamera:
		Info.cameraPos = global_position
		Info.onCamera = true
		Info.chekPoint = body.global_position
		body.emit_signal("save")
		Info.hopSave = Info.hop
		Info.posessedSave = Info.posessed
		Info.posessingSave = Info.posessing


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player") and not body.dead:
		Info.onCamera = false
