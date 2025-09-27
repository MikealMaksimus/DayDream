extends CharacterBody2D

var onArea = false
var gravity = 1400

var blood = preload("res://blood_splash.tscn")
var blow = preload("res://DudeExplos.mp3")
var audio = preload("res://audio_player.tscn")

var resetPos

var posessed = false
var disabled = false
var disableOnReset = false

func _ready() -> void:
	resetPos = global_position
	velocity = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y +=  gravity * delta * 1.6
	else:
		velocity.y = 0
	
	#if Input.is_action_just_pressed("Posess") and onArea:
	#	sacrifice()
	
	move_and_slide()
	
	if disabled:
		$CollisionShape2D.disabled = true
		hide()
		global_position = Info.playerPos
	else:
		$CollisionShape2D.disabled = false

func sacrifice():
	Info.posessing = true
	Info.hop = true
	Info.posessed = load("res://dude.tscn")
	disabled = true
	posessed = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not disabled:
		if not body.cool:
			sacrifice()
#	if body.is_in_group("Player"):
#		onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
#	if body.is_in_group("Player"):
#		onArea = false


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Deadly") and not disabled:
		var p = blood.instantiate()
		p.position = global_position
		get_parent().add_child(p)
		
		var a = audio.instantiate()
		a.sound = blow
		get_parent().add_child(a)
		disabled = true

func reset():
	global_position = resetPos
	show()

func _on_player_reset() -> void:
	if not disableOnReset:
		reset()
		disabled = false
	else:
		disabled = true



func _on_player_drop() -> void:
	posessed = false
	disabled = false
	show()
	print("a")


func _on_player_save() -> void:
	if posessed:
		disableOnReset = true
	else:
		disableOnReset = false
