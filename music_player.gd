extends Node2D

var tracker = 1

var over = load("res://overworld.mp3")
var cave = load("res://Spelunking.mp3")
var hell = load("res://cinderblockmove-91891.mp3")

func _ready() -> void:
	$AudioStreamPlayer.play()



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
