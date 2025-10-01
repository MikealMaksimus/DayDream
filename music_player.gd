extends Node2D

var tracker = 1
var mute = false

var over = load("res://null(1).mp3")
var cave = load("res://null.mp3")
var hell = load("res://gloom. the sole entity they dread art thou(1).mp3")

func _ready() -> void:
	$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mute"):
		if mute:
			$AudioStreamPlayer.volume_db = 0
			mute = false
		else:
			$AudioStreamPlayer.volume_db = -120
			mute = true

func _on_music_changer_change() -> void:
		if Info.track == 1:
			$AudioStreamPlayer.stream = over
			$AudioStreamPlayer.play()
		elif Info.track == 2:
			$AudioStreamPlayer.stream = cave
			$AudioStreamPlayer.play()
		else:
			$AudioStreamPlayer.stream = hell
			$AudioStreamPlayer.play()
