extends Node2D

var text = 0
var tween = null

var earth = preload("res://Sprites2/Earth.png")

func _ready() -> void:
	$Label.visible_ratio = 1
	nextLine()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and $Fade.is_stopped():
		nextLine()

func nextLine():
	# Kill existing tween if running
	if tween and tween.is_valid():
		tween.kill()
		tween = null

	var time := 0.0

	if $Label.visible_ratio == 1.0:
		if text == 0:
			$Label.text = "The stars are filled with graves"
			text = 1
			time = 1
		elif text == 1:
			$Label.text = "Countless of worlds have fallen because they refused to sacrifice. I won't let another one join them"
			text = 2
			time = 2
		elif text == 2:
			$AnimationPlayer.play("new_animation")
			$Fade.start()
			await $AnimationPlayer.animation_finished
			$AnimationPlayer.play_backwards("new_animation")
			$Stars.texture = earth
			text = 3
			time = 0
			await $AnimationPlayer.animation_finished
			nextLine()
		elif text == 3:
			$Label.text = "This world still thinks it is safe. But beneath its soil, something malicous is brewing"
			text = 4
			time = 1.5
		elif text == 4:
			$Label.text = "a hunger that only sacrifice can keep asleep"
			text = 5
			time = 1.0
		elif text == 5:
			$AnimationPlayer.play("new_animation")
			$AudioStreamPlayer/Fader.play("new_animation")
			text = 6
			time = 0.0
			await $AnimationPlayer.animation_finished
			get_tree().change_scene_to_file("res://test_scene.tscn")

		# create a new tween and keep reference
		tween = create_tween()
		tween.tween_property($Label, "visible_ratio", 1.0, time).from(0.0)
	else:
		# If text is mid-animation, immediately show all
		if tween and tween.is_valid():
			tween.kill()
			tween = null
		$Label.visible_ratio = 1.0
