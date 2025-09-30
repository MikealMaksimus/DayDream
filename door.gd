extends Node2D

var onArea = false
var opend = false

signal open

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and Info.key and not opend:
		onArea = true
		$Timer.start()



func _on_timer_timeout() -> void:
	if onArea:
		emit_signal("open")
		opend = true
		Info.key = false
		$AnimationPlayer.play("Open")
		$AudioStreamPlayer.play()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		onArea = false


func _on_player_reset() -> void:
	opend = false
	$AnimationPlayer.play("RESET")
