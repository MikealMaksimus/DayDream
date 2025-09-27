extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Info.cameraPos = global_position
		Info.chekPoint = body.global_position
		
		Info.hopSave = Info.hop
		Info.posessedSave = Info.posessed
		Info.posessingSave = Info.posessing
