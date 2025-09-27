extends CharacterBody2D

var onArea = false
var gravity = 1400

var blood = preload("res://blood_splash.tscn")
var blow = preload("res://DudeExplos.mp3")
var audio = preload("res://audio_player.tscn")

func _ready() -> void:
	velocity = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y +=  gravity * delta * 1.6
	else:
		velocity.y = 0
	
	if Input.is_action_just_pressed("Posess") and onArea:
		sacrifice()
	
	move_and_slide()

func sacrifice():
	Info.posessing = true
	Info.hop = true
	Info.posessed = load("res://dude.tscn")
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.cool:
		sacrifice()
#	if body.is_in_group("Player"):
#		onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
#	if body.is_in_group("Player"):
#		onArea = false


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Deadly"):
		var p = blood.instantiate()
		p.position = global_position
		get_parent().add_child(p)
		
		var a = audio.instantiate()
		a.sound = blow
		get_parent().add_child(a)
		queue_free()
