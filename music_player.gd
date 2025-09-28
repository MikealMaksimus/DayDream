extends Node2D

var tracker = 1

var over = load("res://cinderblockmove-91891.mp3")
var cave = load("res://cinderblockmove-91891.mp3")
var hell = load("res://cinderblockmove-91891.mp3")

func _ready() -> void:
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not Info.track == tracker:
		if Info.track == 1:
			$AudioStreamPlayer.stream = over
			$AudioStreamPlayer.play()
		elif Info.track == 2:
			$AudioStreamPlayer.stream = cave
			$AudioStreamPlayer.play()
		else:
			$AudioStreamPlayer.stream = hell
			$AudioStreamPlayer.play()
	
	tracker = Info.track
