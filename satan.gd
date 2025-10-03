extends Sprite2D


func _ready() -> void:
	$Deaths.hide()
	$Time.hide()


func _process(delta: float) -> void:
	$Deaths.text = "Deaths " + str(Info.deaths)
	var min = floor(Info.time / 60.0)
	var sec = Info.time % 60
	$Time.text = "Time " + "%02d:%02d" % [min, sec]

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.queue_free()
		$AnimationPlayer.play("Posess")
		$Deaths.show()
		$Time.show()
