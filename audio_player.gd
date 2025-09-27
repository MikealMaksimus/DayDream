extends Node2D

var sound

func _ready() -> void:
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play()
	print(sound)
