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

var dead = false

func _ready() -> void:
	resetPos = global_position
	velocity = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dead:
		collision_layer |= 1 << 0
		$Dude.frame = 1
	
	
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
	if body.is_in_group("Player") and not disabled and not dead:
		if not body.cool and not Info.posessing:
			sacrifice()
#	if body.is_in_group("Player"):
#		onArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
#	if body.is_in_group("Player"):
#		onArea = false


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Deadly") and not disabled:
		dead = true
		$AudioStreamPlayer.play()

func reset():
	collision_layer &= ~(1 << 0)
	global_position = resetPos
	show()
	dead = false

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
	$Dude.frame = 0


func _on_player_save() -> void:
	if posessed:
		disableOnReset = true
	else:
		disableOnReset = false
